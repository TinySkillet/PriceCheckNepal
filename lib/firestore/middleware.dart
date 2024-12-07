import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<List<Map<String, dynamic>>> searchLaptopsByName(String query) async {
    final laptopsRef = FirebaseFirestore.instance.collection('laptops');
    final snapshot = await laptopsRef.get();

    List<Map<String, dynamic>> matchingLaptops = [];

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final name = data['name'];
      final ratio_ = ratio(name.toLowerCase(), query.toLowerCase());

      if (ratio_ >= 80) {
        data['id'] = doc.id;
        matchingLaptops.add(data);
      }
    }

    matchingLaptops.sort((a, b) {
      final aRatio = ratio(a['name'].toLowerCase(), query.toLowerCase());
      final bRatio = ratio(b['name'].toLowerCase(), query.toLowerCase());
      return bRatio.compareTo(aRatio);
    });

    return matchingLaptops;
  }

  Future<Map<String, dynamic>> getLaptopById(String id) async {
    final laptopDoc = await firestore.collection('laptops').doc(id).get();
    if (laptopDoc.exists) {
      return laptopDoc.data()!;
    } else {
      throw Exception("Laptop not found!");
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

      // check if laptop falls in the price range
      final minSourcePrice = data['sources'].fold<double>(double.maxFinite,
          (min, source) => min < source['price'] ? min : source['price']);
      if (minPrice != null && minSourcePrice < minPrice) {
        continue;
      }
      if (maxPrice != null && minSourcePrice > maxPrice) {
        continue;
      }

      // check if laptop matches the ram filters
      if (rams != null &&
          data['ram'] != null &&
          !rams.contains(data['ram'].split(" ")[0])) {
        continue;
      }

      // check if laptop matches the storage filters
      if (storages != null &&
          data['storage'] != null &&
          !storages.contains(data['storage'].split(" ")[0])) {
        continue;
      }

      // check if laptop matches the brand name
      if (brand != null && data['brand'].toLowerCase() != brand.toLowerCase()) {
        continue;
      }

      // check if the laptop meets the name criteria
      if (name != null) {
        final ratio_ = ratio(data['name'].toLowerCase(), name.toLowerCase());
        if (ratio_ < 70) {
          continue;
        }
      }

      // Add the laptop to the filtered list
      data['id'] = doc.id;
      filteredLaptops.add(data);
    }

    // Sort the filtered laptops
    filteredLaptops.sort((a, b) {
      final aMinPrice = a['sources'].fold<double>(double.maxFinite,
          (min, source) => min < source['price'] ? min : source['price']);
      final bMinPrice = b['sources'].fold<double>(double.maxFinite,
          (min, source) => min < source['price'] ? min : source['price']);

      if (aMinPrice != bMinPrice) {
        return aMinPrice.compareTo(bMinPrice);
      }

      if (brand != null) {
        if (a['brand'].toLowerCase() != b['brand'].toLowerCase()) {
          return b['brand'].toLowerCase().compareTo(a['brand'].toLowerCase());
        }
      }

      if (name != null) {
        final aRatio = ratio(a['name'].toLowerCase(), name.toLowerCase());
        final bRatio = ratio(b['name'].toLowerCase(), name.toLowerCase());
        return bRatio.compareTo(aRatio);
      }

      return 0;
    });

    return filteredLaptops;
  }
}
