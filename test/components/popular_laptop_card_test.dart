import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:price_check_np/components/popular_laptop_card.dart';

void main() {
  // Sample laptop data for testing
  final testLaptop = {
    "name": "Test Laptop",
    "ram": "16 GB",
    "storage": "512 GB",
    "image_url": "https://example.com/laptop.jpg"
  };

  group('PopularLaptopCard', () {
    // Test widget rendering
    testWidgets('renders laptop card correctly', (WidgetTester tester) async {
      // Build our widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PopularLaptopCard(laptop: testLaptop),
          ),
        ),
      );

      // Verify laptop name is displayed
      expect(find.text('Test Laptop'), findsOneWidget);

      // Verify specs text is displayed
      expect(find.text('RAM: 16 | STORAGE: 512'), findsOneWidget);

      // Verify image is rendered
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    // Test default image placeholder
    testWidgets('uses default image when image_url is null',
        (WidgetTester tester) async {
      final laptopWithNoImage = {...testLaptop, "image_url": null};

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PopularLaptopCard(laptop: laptopWithNoImage),
          ),
        ),
      );

      // Verify default image placeholder is shown
      expect(find.byType(Image), findsOneWidget);
    });

    // Test text overflow
    testWidgets('handles long laptop names', (WidgetTester tester) async {
      final longNameLaptop = {
        ...testLaptop,
        "name": "This is a very long laptop name that should be truncated"
      };

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PopularLaptopCard(laptop: longNameLaptop),
          ),
        ),
      );

      // Find the text widget
      final textWidget =
          tester.widget<Text>(find.text(longNameLaptop['name']!));

      // Verify text overflow is set correctly
      expect(textWidget.overflow, TextOverflow.ellipsis);
      expect(textWidget.maxLines, 1);
    });
  });
}
