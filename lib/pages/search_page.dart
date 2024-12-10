import 'package:flutter/material.dart';
import 'package:price_check_np/components/appbar.dart';
import 'package:price_check_np/components/filter_drawer.dart';
import 'package:price_check_np/components/search_card.dart';
import 'package:price_check_np/components/search_field.dart';
import 'package:price_check_np/components/tile.dart';
import 'package:price_check_np/firestore/middleware.dart';
import 'package:price_check_np/models/filter_provider.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  final Map<String, Object?>? searchParams;

  const SearchPage({super.key, this.searchParams});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String>? selectedRamOptions;
  List<String>? selectedStorageOptions;
  final TextEditingController _laptopNameController = TextEditingController();
  String? selectedBrand;
  List<Map<String, dynamic>> searchResults = [];

  @override
  void initState() {
    super.initState();
    // Extract values from the map if available
    selectedRamOptions = widget.searchParams?['selected_rams'] != null
        ? List<String>.from(widget.searchParams!['selected_rams'] as List)
        : [];
    selectedStorageOptions = widget.searchParams?['selected_storages'] != null
        ? List<String>.from(widget.searchParams!['selected_storages'] as List)
        : [];
    selectedBrand = widget.searchParams?['selected_brands'] as String?;
  }

  void showSearchResults() async {
    FirestoreMiddleware middleware = FirestoreMiddleware();
    final filterData =
        Provider.of<FilterProvider>(context, listen: false).filterData;
    // Fetch the search results from Firestore
    List<Map<String, dynamic>> laptops = await middleware.filterAndSortLaptops(
      rams: filterData.selectedRamOptions,
      storages: filterData.selectedStorageOptions,
      brand: filterData.selectedBrand,
      name: _laptopNameController.text,
      minPrice: filterData.minPrice,
      maxPrice: filterData.maxPrice,
    );

    // Update the UI with the search results
    setState(() {
      searchResults = laptops;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        isBackBtnRequired: true,
        title: "Search Laptops",
        centerTitle: true,
      ),
      endDrawer: const FilterDrawer(),
      onEndDrawerChanged: (isOpened) {
        // when drawer is closed, refresh the search results accordingly
        if (!isOpened) {
          showSearchResults();
        }
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchField(
            controller: _laptopNameController,
            autofocus: true,
            hintText: "Search for laptops",
            onComplete: showSearchResults,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: MyTile(
                tiletext: "Recently Viewed",
                onPressed: () {
                  context.push("/recent-views");
                }),
          ),
          const SizedBox(
            height: 20,
          ),
          // Search results
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final laptop = searchResults[index];
                return SearchCard(laptop: laptop);
              },
            ),
          ),
        ],
      ),
    );
  }
}
