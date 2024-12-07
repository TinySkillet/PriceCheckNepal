import 'package:flutter/material.dart';
import 'package:price_check_np/components/appbar.dart';

class LaptopSpecsPage extends StatelessWidget {
  final Map<String, dynamic> laptop;

  const LaptopSpecsPage({
    super.key,
    required this.laptop,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        isBackBtnRequired: true,
        title: "Specs page",
      ),
      body: Center(
        child: Text(
            'Laptop: ${laptop['name']}'), // Displaying laptop name as an example
      ),
    );
  }
}
