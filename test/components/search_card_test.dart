import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:price_check_np/components/search_card.dart';

void main() {
  // Sample laptop data for testing
  final testLaptop = {
    'id': '123',
    'name': 'Test Laptop',
    'brand': 'Test Brand',
    'ram': '16 GB',
    'storage': '512 GB',
    'image_url': 'https://example.com/laptop.jpg'
  };

  group('SearchCard', () {
    // Test widget rendering with complete data
    testWidgets('renders search card correctly with full laptop data',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchCard(laptop: testLaptop),
          ),
        ),
      );

      // Verify laptop name is displayed
      expect(find.text('Test Laptop'), findsOneWidget);

      // Verify subtitle details
      expect(find.text('Brand: Test Brand'), findsOneWidget);
      expect(find.text('RAM: 16 GB'), findsOneWidget);
      expect(find.text('Storage: 512 GB'), findsOneWidget);

      // Verify image is rendered
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    // Test widget rendering with partial/missing data
    testWidgets('handles missing laptop data gracefully',
        (WidgetTester tester) async {
      final incompleteData = {
        'name': null,
        'brand': null,
        'ram': null,
        'storage': null,
        'image_url': null
      };

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchCard(laptop: incompleteData),
          ),
        ),
      );

      // Verify default text is shown for missing data
      expect(find.text('Unknown Laptop'), findsOneWidget);
      expect(find.text('Brand: Unknown'), findsOneWidget);
      expect(find.text('RAM: Unknown'), findsOneWidget);
      expect(find.text('Storage: Unknown'), findsOneWidget);

      // Verify placeholder image is shown
      expect(find.byType(Image), findsOneWidget);
    });
  });
}
