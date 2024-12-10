import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

class FirestoreMiddleware {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getPopularLaptops() async {
    final laptopsRef = firestore.collection('laptops');
    final snapshot = await laptopsRef.get();

    List<Map<String, dynamic>> laptopsWithMultipleSources = [];

    for (final doc in snapshot.docs) {
      final data = doc.data();
      if (data['sources'].length > 1) {
        data['id'] = doc.id;
        laptopsWithMultipleSources.add(data);
      }
    }
    // sort by highest no of sources
    laptopsWithMultipleSources.sort((a, b) {
      return b['sources'].length.compareTo(a['sources'].length);
    });

    return laptopsWithMultipleSources;
  }

  Future<Map<String, dynamic>> getLaptopById(String id) async {
    final laptopDoc = await firestore.collection('laptops').doc(id).get();
    if (laptopDoc.exists) {
      return laptopDoc.data()!;
    } else {
      throw Exception("Laptop not found!");
    }
  }

  Future<void> storeRecentSearch(String laptopId) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    try {
      final recentSearchesRef =
          firestore.collection('recent_searches').doc(userId);

      // Get current recent searches
      final docSnapshot = await recentSearchesRef.get();

      List<String> recentSearches = [];
      if (docSnapshot.exists) {
        recentSearches =
            List<String>.from(docSnapshot.data()?['searches'] ?? []);
      }

      // remove the laptop ID if it already exists
      recentSearches.remove(laptopId);

      // add the new laptop ID to the beginning of the list
      recentSearches.insert(0, laptopId);

      // keeping only the last 20 searches
      if (recentSearches.length > 20) {
        recentSearches = recentSearches.sublist(0, 20);
      }

      await recentSearchesRef.set({
        'searches': recentSearches,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      log(
        'Error storing recent search: $e',
        time: DateTime.now(),
      );
    }
  }

  Future<List<Map<String, dynamic>>> getRecentSearches() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return []; // Return empty list if no user logged in

    try {
      final recentSearchesDoc =
          await firestore.collection('recent_searches').doc(userId).get();

      if (!recentSearchesDoc.exists) return [];

      List<String> recentSearchIds =
          List<String>.from(recentSearchesDoc.data()?['searches'] ?? []);

      if (recentSearchIds.isEmpty) return [];

      final querySnapshot = await firestore
          .collection('laptops')
          .where(FieldPath.documentId, whereIn: recentSearchIds)
          .get();

      return querySnapshot.docs.map((doc) {
        final laptopData = doc.data();
        laptopData['id'] = doc.id;
        return laptopData;
      }).toList();
    } catch (e) {
      log(
        'Error retrieving recent searches: $e',
        time: DateTime.now(),
      );
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> filterAndSortLaptops({
    double? minPrice,
    double? maxPrice,
    List<String>? rams,
    List<String>? storages,
    String? brand,
    String? name,
  }) async {
    final laptopsRef = FirebaseFirestore.instance.collection('laptops');
    final snapshot = await laptopsRef.get();
    List<Map<String, dynamic>> filteredLaptops = [];

    for (final doc in snapshot.docs) {
      final data = doc.data();

      // Price filtering
      final minSourcePrice = (data['sources'] as Map<String, dynamic>)
          .values
          .map((source) => (source['price'] is int
              ? (source['price'] as int).toDouble()
              : source['price'] is double
                  ? source['price'] as double
                  : 0.0)) // Default to 0.0 for missing values
          .reduce((min, price) => min < price ? min : price);

      if ((minPrice != null && minSourcePrice < minPrice) ||
          (maxPrice != null && minSourcePrice > maxPrice)) {
        continue;
      }

      // RAM filtering
      if (rams != null && rams.isNotEmpty) {
        final laptopRam = data['ram']?.toLowerCase().split(" ").first;
        bool ramMatch = rams.any((selectedRam) =>
            laptopRam != null && laptopRam.contains(selectedRam.toLowerCase()));
        if (!ramMatch) continue;
      }

      // Storage filtering
      if (storages != null && storages.isNotEmpty) {
        final laptopStorage = data['storage']?.toLowerCase().split(" ").first;
        bool storageMatch = storages.any((selectedStorage) =>
            laptopStorage != null &&
            laptopStorage.contains(selectedStorage.toLowerCase()));
        if (!storageMatch) continue;
      }

      // Brand filtering

      if (brand != null &&
          brand != "" &&
          (data['brand'] == null ||
              data['brand'].toLowerCase() != brand.toLowerCase())) {
        continue;
      }

      // Name filtering (only apply if name is provided)
      int ratio_ = 0;
      if (name != null && name.isNotEmpty && name != "") {
        ratio_ = ratio(data['name']?.toLowerCase() ?? '', name.toLowerCase());
        if (ratio_ < 30) {
          continue;
        }
      }

      data['id'] = doc.id;
      data['ratio_'] = ratio_; // ratio for sorting later
      filteredLaptops.add(data);
    }

    // Sorting logic
    filteredLaptops.sort((a, b) {
      // Sort by name ratio in descending order if name filtering is applied
      final aRatio = a['ratio_'] as int? ?? 0;
      final bRatio = b['ratio_'] as int? ?? 0;
      if (aRatio != bRatio) {
        return bRatio.compareTo(aRatio);
      }

      // Sort by price in ascending order as a secondary criterion
      final aMinPrice = (a['sources'] as Map<String, dynamic>)
          .values
          .map((source) => (source['price'] is int
              ? (source['price'] as int).toDouble()
              : source['price'] is double
                  ? source['price'] as double
                  : 0.0))
          .reduce((min, price) => min < price ? min : price);
      final bMinPrice = (b['sources'] as Map<String, dynamic>)
          .values
          .map((source) => (source['price'] is int
              ? (source['price'] as int).toDouble()
              : source['price'] is double
                  ? source['price'] as double
                  : 0.0))
          .reduce((min, price) => min < price ? min : price);
      if (aMinPrice != bMinPrice) {
        return aMinPrice.compareTo(bMinPrice);
      }

      // Sort by brand alphabetically if brand filtering is applied
      if (brand != null) {
        return (a['brand']?.toLowerCase() ?? '')
            .compareTo(b['brand']?.toLowerCase() ?? '');
      }

      return 0;
    });

    return filteredLaptops.map((laptop) {
      laptop.remove('ratio_');
      return laptop;
    }).toList();
  }
}
