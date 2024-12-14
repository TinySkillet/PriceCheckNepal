import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:price_check_np/components/tile.dart'; // Update with the correct import path

void main() {
  testWidgets('MyTile triggers onPressed when tapped',
      (WidgetTester tester) async {
    // Define a mock onPressed function
    bool isPressed = false;
    void mockOnPressed() {
      isPressed = true;
    }

    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MyTile(
            tiletext: 'Test Tile',
            onPressed: mockOnPressed,
          ),
        ),
      ),
    );

    // Find the MyTile widget by text
    final tileFinder = find.text('Test Tile');

    // Ensure the widget is in the tree
    expect(tileFinder, findsOneWidget);

    // Tap the widget
    await tester.tap(tileFinder);

    // Rebuild the widget after the tap
    await tester.pump();

    // Check if onPressed was triggered
    expect(isPressed, isTrue);
  });
}
