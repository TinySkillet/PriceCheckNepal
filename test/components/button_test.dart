import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:price_check_np/components/button.dart';

void main() {
  // Test MyButton with text and icon
  testWidgets('MyButton renders with text and icon',
      (WidgetTester tester) async {
    final mockOnPressed = () {};
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyButton(
            onPressed: mockOnPressed,
            buttontext: 'Button Text',
            buttonicon: Image.asset('assets/images/check_icon.png'),
          ),
        ),
      ),
    );

    // Verify button text is present
    expect(find.text('Button Text'), findsOneWidget);

    // Verify button icon is present
    expect(find.byType(Image), findsOneWidget);
  });

  // Test MyButton with text only
  testWidgets('MyButton renders with text only', (WidgetTester tester) async {
    final mockOnPressed = () {};
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyButton(
            onPressed: mockOnPressed,
            buttontext: 'Button Text',
          ),
        ),
      ),
    );

    // Verify button text is present
    expect(find.text('Button Text'), findsOneWidget);

    // Verify button icon is not present
    expect(find.byType(Image), findsNothing);
  });

  // Test MyButton click behavior
  testWidgets('MyButton triggers onPressed callback',
      (WidgetTester tester) async {
    bool wasPressed = false;
    final mockOnPressed = () {
      wasPressed = true;
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyButton(
            onPressed: mockOnPressed,
            buttontext: 'Button Text',
          ),
        ),
      ),
    );

    // Tap the button
    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();

    // Verify the callback was triggered
    expect(wasPressed, isTrue);
  });

  // Test MyButton style
  testWidgets('MyButton has correct style', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyButton(
            onPressed: () {},
            buttontext: 'Button Text',
          ),
        ),
      ),
    );
  });
}
