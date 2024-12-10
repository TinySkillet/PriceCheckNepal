import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:price_check_np/models/filter_provider.dart';
import 'package:provider/provider.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({super.key});

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  // RAM options
  final List<String> ramOptions = [
    '4GB',
    '8GB',
    '16GB',
    '18GB',
    '24GB',
    '32GB'
  ];
  final List<String> storageOptions = [
    '64GB',
    '128GB',
    '256GB',
    '512GB',
    '1TB',
    '2TB',
  ];
  final List<String> brandOptions = [
    'DELL',
    'HP',
    'LENOVO',
    'APPLE',
    'ASUS',
    'ACER',
    'AVITA',
    'MSI',
    'MICROSOFT',
  ];

  final double minPrice = 32999;
  final double maxPrice = 565000;

  // Selected options
  late List<String> selectedRamOptions;
  late String? selectedBrand;
  late List<String> selectedStorageOptions;
  double selectedMinPrice = 32999;
  double selectedMaxPrice = 565000;

  @override
  void initState() {
    super.initState();
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    selectedRamOptions =
        List<String>.from(filterProvider.filterData.selectedRamOptions);
    selectedStorageOptions =
        List<String>.from(filterProvider.filterData.selectedStorageOptions);
    selectedBrand = filterProvider.filterData.selectedBrand;

    selectedMinPrice = filterProvider.filterData.minPrice == 0
        ? 32999
        : filterProvider.filterData.minPrice;
    selectedMaxPrice = filterProvider.filterData.maxPrice == double.infinity
        ? 565000
        : filterProvider.filterData.maxPrice;
  }

  void _clearFilters() {
    setState(() {
      selectedRamOptions.clear();
      selectedStorageOptions.clear();
      selectedBrand = null;
      selectedMinPrice = minPrice;
      selectedMaxPrice = maxPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      shape: const BeveledRectangleBorder(),
      backgroundColor: Theme.of(context).primaryColorLight,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Clear Filters Button
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 25, right: 25),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(
                        Theme.of(context).primaryColorDark,
                      ),
                      padding:
                          const WidgetStatePropertyAll(EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      )),
                      textStyle: const WidgetStatePropertyAll(TextStyle(
                        fontFamily: "Noto Sans",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                      backgroundColor: WidgetStatePropertyAll(
                        Theme.of(context).primaryColorLight,
                      ),
                    ),
                    onPressed: () {
                      _clearFilters();
                      Provider.of<FilterProvider>(context, listen: false)
                          .updateFilters({
                        'selected_rams': selectedRamOptions,
                        'selected_storages': selectedStorageOptions,
                        'selected_brand': selectedBrand,
                        'min_price': selectedMinPrice,
                        'max_price': selectedMaxPrice,
                      });
                      context.pop();
                    },
                    child: const Text('Clear Filters'),
                  ),
                ),

                // RAM Section
                _buildSectionTitle('RAM'),
                ..._buildMultiSelectOptions(ramOptions, selectedRamOptions,
                    (value) {
                  setState(() {
                    if (selectedRamOptions.contains(value)) {
                      selectedRamOptions.remove(value);
                    } else {
                      selectedRamOptions.add(value);
                    }
                  });
                }),

                // Storage Section
                _buildSectionTitle('Storage'),
                ..._buildMultiSelectOptions(
                    storageOptions, selectedStorageOptions, (value) {
                  setState(() {
                    if (selectedStorageOptions.contains(value)) {
                      selectedStorageOptions.remove(value);
                    } else {
                      selectedStorageOptions.add(value);
                    }
                  });
                }),

                // Brand Section
                _buildSectionTitle('Brand'),
                ...brandOptions.map((option) {
                  return RadioListTile<String>(
                    key: ValueKey(option),
                    title: Text(option),
                    value: option,
                    groupValue: selectedBrand,
                    contentPadding: const EdgeInsets.only(left: 16),
                    onChanged: (String? value) {
                      setState(() {
                        selectedBrand = value;
                      });
                    },
                  );
                }),

                _buildSectionTitle("Price"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      const Text(
                        'Min Price: NRS',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Noto Sans"),
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: const SliderThemeData(
                            trackHeight: 9,
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 8,
                            ),
                          ),
                          child: Slider(
                            value: selectedMinPrice,
                            min: minPrice,
                            max: maxPrice,
                            activeColor: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(.7),
                            thumbColor: Theme.of(context).primaryColorDark,
                            divisions: 20,
                            label: selectedMinPrice.toStringAsFixed(2),
                            onChanged: (double value) {
                              setState(() {
                                value > selectedMaxPrice
                                    ? selectedMinPrice = selectedMaxPrice
                                    : selectedMinPrice = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      const Text(
                        'Max Price: NRS',
                        style: TextStyle(
                          fontFamily: "Noto Sans",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: const SliderThemeData(
                            trackHeight: 9,
                            thumbShape: RoundSliderThumbShape(
                              pressedElevation: 1,
                              enabledThumbRadius: 8,
                            ),
                          ),
                          child: Slider(
                            activeColor: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(.7),
                            thumbColor: Theme.of(context).primaryColorDark,
                            value: selectedMaxPrice,
                            min: minPrice,
                            max: maxPrice,
                            divisions: 20,
                            label: selectedMaxPrice.toStringAsFixed(2),
                            onChanged: (double value) {
                              setState(() {
                                value < selectedMinPrice
                                    ? selectedMaxPrice = selectedMinPrice
                                    : selectedMaxPrice = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Apply Filters Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor: WidgetStatePropertyAll(
                            Theme.of(context).primaryColorDark,
                          ),
                          padding:
                              const WidgetStatePropertyAll(EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          )),
                          textStyle: const WidgetStatePropertyAll(TextStyle(
                            fontFamily: "Noto Sans",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                          backgroundColor: WidgetStatePropertyAll(
                            Theme.of(context).primaryColorLight,
                          )),
                      onPressed: () {
                        Provider.of<FilterProvider>(context, listen: false)
                            .updateFilters({
                          'selected_rams': selectedRamOptions,
                          'selected_storages': selectedStorageOptions,
                          'selected_brand': selectedBrand,
                          'min_price': selectedMinPrice,
                          'max_price': selectedMaxPrice,
                        });
                        context.pop();
                      },
                      child: const Text('Apply Filters'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to create section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 25),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: "Noto Sans",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }

  // Method to build multi-select checkbox options
  List<Widget> _buildMultiSelectOptions(List<String> options,
      List<String> selectedOptions, void Function(String) onChanged) {
    return options.map((option) {
      return CheckboxListTile(
        title: Text(option),
        value: selectedOptions.contains(option),
        onChanged: (bool? value) {
          onChanged(option);
        },
        controlAffinity: ListTileControlAffinity.leading,
      );
    }).toList();
  }
}
