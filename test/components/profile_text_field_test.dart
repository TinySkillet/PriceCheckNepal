import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:price_check_np/components/profile_text_field.dart';

void main() {
  testWidgets('ProfileTextField displays input text correctly',
      (WidgetTester tester) async {
    // Setup controller and create the widget
    final controller = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileTextField(
            controller: controller,
            hintText: 'Enter name',
            obsecureText: false,
            isEnabled: true,
          ),
        ),
      ),
    );

    // Enter some text into the field
    await tester.enterText(find.byType(TextField), 'John Doe');
    await tester.pump();

    // Verify the text entered is correct
    expect(controller.text, 'John Doe');
    expect(find.text('John Doe'), findsOneWidget);
  });

  testWidgets('ProfileTextField toggles password visibility',
      (WidgetTester tester) async {
    // Setup controller and create the widget with obsecureText set to true
    final controller = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileTextField(
            controller: controller,
            hintText: 'Enter password',
            obsecureText: true,
            isEnabled: true,
          ),
        ),
      ),
    );

    // Initially, the text field should be obscured
    expect(find.byIcon(Icons.visibility_off_rounded), findsOneWidget);

    // Tap the suffix icon to toggle visibility
    await tester.tap(find.byIcon(Icons.visibility_off_rounded));
    await tester.pump();

    // Now the text field should be visible
    expect(find.byIcon(Icons.visibility_sharp), findsOneWidget);
  });

  testWidgets('ProfileTextField is disabled when isEnabled is false',
      (WidgetTester tester) async {
    // Setup controller and create the widget with isEnabled set to false
    final controller = TextEditingController();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileTextField(
            controller: controller,
            hintText: 'Enter name',
            obsecureText: false,
            isEnabled: false,
          ),
        ),
      ),
    );

    // Verify the text field is disabled
    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.enabled, false);
  });

  testWidgets('ProfileTextField displays prefixIcon when provided',
      (WidgetTester tester) async {
    // Setup controller and create the widget with a prefix icon
    final controller = TextEditingController();
    final icon = Icon(Icons.person);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileTextField(
            controller: controller,
            hintText: 'Enter name',
            obsecureText: false,
            isEnabled: true,
            prefixIcon: icon,
          ),
        ),
      ),
    );

    // Verify that the prefix icon is displayed
    expect(find.byIcon(Icons.person), findsOneWidget);
  });
}
