class FilterData {
  final List<String> selectedRamOptions;
  final List<String> selectedStorageOptions;
  final String? selectedBrand;
  final double minPrice;
  final double maxPrice;

  const FilterData({
    this.selectedRamOptions = const [],
    this.selectedStorageOptions = const [],
    this.selectedBrand,
    this.minPrice = 0.0,
    this.maxPrice = double.infinity,
  });
}
