import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:price_check_np/components/snackbar.dart';

void main() {
  group('MySnackbar', () {
    // Test basic rendering and properties
    testWidgets('creates snackbar with correct message',
        (WidgetTester tester) async {
      const testMessage = 'Test Snackbar Message';

      // Create a scaffold with a button to show the snackbar
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    MySnackbar(message: testMessage),
                  );
                },
                child: const Text('Show Snackbar'),
              ),
            ),
          ),
        ),
      );

      // Tap the button to show the snackbar
      await tester.tap(find.text('Show Snackbar'));
      await tester.pumpAndSettle();

      // Verify the snackbar is displayed with the correct message
      expect(find.text(testMessage), findsOneWidget);
    });

    // Test snackbar styling
    testWidgets('has correct styling', (WidgetTester tester) async {
      const testMessage = 'Styled Snackbar';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    MySnackbar(message: testMessage),
                  );
                },
                child: const Text('Show Snackbar'),
              ),
            ),
          ),
        ),
      );

      // Show the snackbar
      await tester.tap(find.text('Show Snackbar'));
      await tester.pumpAndSettle();

      // Find the Text widget in the snackbar
      final textWidget = tester.widget<Text>(find.text(testMessage));

      // Verify text style
      expect(textWidget.style?.fontFamily, 'Noto Sans');
      expect(textWidget.style?.fontSize, 16);
      expect(textWidget.style?.fontWeight, FontWeight.bold);

      // Find the SnackBar widget
      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));

      // Verify background color
      expect(snackBar.backgroundColor, const Color.fromRGBO(93, 88, 88, 1.0));
    });

    // Test snackbar duration
    testWidgets('has correct duration', (WidgetTester tester) async {
      const testMessage = 'Duration Test';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    MySnackbar(message: testMessage),
                  );
                },
                child: const Text('Show Snackbar'),
              ),
            ),
          ),
        ),
      );

      // Show the snackbar
      await tester.tap(find.text('Show Snackbar'));
      await tester.pumpAndSettle();

      // Find the SnackBar widget
      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));

      // Verify duration
      expect(snackBar.duration, const Duration(seconds: 1));
    });
  });
}
