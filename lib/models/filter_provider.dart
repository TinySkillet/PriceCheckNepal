import 'package:flutter/material.dart';
import 'package:price_check_np/models/filter_data.dart';

class FilterProvider extends ChangeNotifier {
  FilterData _filterData = const FilterData();

  FilterData get filterData => _filterData;

  void updateFilters(Map<String, Object?> filters) {
    _filterData = FilterData(
      selectedRamOptions: filters['selected_rams'] as List<String>,
      selectedStorageOptions: filters['selected_storages'] as List<String>,
      selectedBrand: filters['selected_brand'] as String?,
      minPrice: filters['min_price'] as double,
      maxPrice: filters['max_price'] as double,
    );
    notifyListeners();
  }
}
