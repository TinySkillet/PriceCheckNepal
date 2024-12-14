import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:price_check_np/components/trending_laptop_card.dart';

void main() {
  testWidgets(
      'TrendingLaptopCard displays laptop name, RAM, and storage correctly',
      (WidgetTester tester) async {
    // Setup test data
    final laptopData = {
      "name": "Laptop ABC",
      "ram": "8 GB",
      "storage": "512 GB SSD",
      "image_url": "https://example.com/laptop_image.jpg",
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TrendingLaptopCard(laptop: laptopData),
        ),
      ),
    );

    // Verify that laptop name, RAM, and storage are displayed correctly
    expect(find.text("Laptop ABC"), findsOneWidget);
    expect(find.text("RAM: 8 | STORAGE: 512"), findsOneWidget);
  });

  testWidgets(
      'TrendingLaptopCard displays image correctly and shows error widget on image load failure',
      (WidgetTester tester) async {
    // Setup test data with a valid image URL
    final laptopData = {
      "name": "Laptop XYZ",
      "ram": "16 GB",
      "storage": "1 TB SSD",
      "image_url": "https://example.com/valid_image_url.jpg", // valid URL
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TrendingLaptopCard(laptop: laptopData),
        ),
      ),
    );

    // Verify that the CachedNetworkImage widget is found (meaning image is being loaded)
    expect(find.byType(CachedNetworkImage), findsOneWidget);

    // Setup test data with an invalid image URL
    final invalidLaptopData = {
      "name": "Laptop XYZ",
      "ram": "16 GB",
      "storage": "1 TB SSD",
      "image_url": "https://example.com/invalid_image_url.jpg", // invalid URL
    };

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: TrendingLaptopCard(laptop: invalidLaptopData),
      ),
    ));

    // Verify the error widget (asset image) is displayed when image URL is invalid
    expect(find.byType(Image), findsOneWidget);
  });
}
