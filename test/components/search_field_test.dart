import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:price_check_np/components/search_field.dart';

void main() {
  group('SearchField', () {
    // Test basic rendering
    testWidgets('renders search field with correct hint text',
        (WidgetTester tester) async {
      const testHintText = 'Search laptops';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              hintText: testHintText,
              autofocus: false,
            ),
          ),
        ),
      );

      // Verify hint text is displayed
      expect(find.text(testHintText), findsOneWidget);

      // Verify SVG search icon is present
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    // Test autofocus functionality
    testWidgets('respects autofocus parameter', (WidgetTester tester) async {
      // Test with autofocus true
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              hintText: 'Autofocus Test',
              autofocus: true,
            ),
          ),
        ),
      );

      // Find the TextField
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.autofocus, isTrue);

      // Test with autofocus false
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              hintText: 'No Autofocus Test',
              autofocus: false,
            ),
          ),
        ),
      );

      // Find the TextField again
      final textFieldNoAutofocus =
          tester.widget<TextField>(find.byType(TextField));
      expect(textFieldNoAutofocus.autofocus, isFalse);
    });

    // Test callback functionality
    testWidgets('handles onTap and onComplete callbacks',
        (WidgetTester tester) async {
      bool onTapCalled = false;
      bool onCompleteCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              hintText: 'Callback Test',
              autofocus: false,
              onTap: () => onTapCalled = true,
              onComplete: () => onCompleteCalled = true,
            ),
          ),
        ),
      );

      // Tap the text field
      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      expect(onTapCalled, isTrue);

      // Simulate editing completion
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(onCompleteCalled, isTrue);
    });

    // Test decoration and styling
    testWidgets('has correct decoration', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              hintText: 'Decoration Test',
              autofocus: false,
            ),
          ),
        ),
      );

      // Find the TextField
      final textField = tester.widget<TextField>(find.byType(TextField));

      // Verify input decoration
      expect(textField.decoration?.filled, isTrue);
      expect(textField.decoration?.fillColor, Colors.white);
      expect(textField.decoration?.border, isNotNull);
      expect(textField.decoration?.prefixIcon, isNotNull);
    });
  });
}
