import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:price_check_np/components/alert_dialog.dart';

void main() {
  group('MyAlertDialog Widget Tests', () {
    testWidgets('renders title, errorMessage, and buttonText correctly',
        (WidgetTester tester) async {
      // Arrange
      const testTitle = 'Test Title';
      const testMessage = 'This is an error message.';
      const testButtonText = 'OK';

      await tester.pumpWidget(
        MaterialApp(
          home: MyAlertDialog(
            title: testTitle,
            errorMessage: testMessage,
            buttonText: testButtonText,
            onPressed: () {},
          ),
        ),
      );

      // Assert
      expect(find.text(testTitle), findsOneWidget);
      expect(find.text(testMessage), findsOneWidget);
      expect(find.text(testButtonText), findsOneWidget);
    });

    testWidgets('button press triggers onPressed callback',
        (WidgetTester tester) async {
      // Arrange
      bool buttonPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: MyAlertDialog(
            title: 'Test Title',
            errorMessage: 'Error Message',
            buttonText: 'Press Me',
            onPressed: () {
              buttonPressed = true;
            },
          ),
        ),
      );

      // Act
      await tester.tap(find.text('Press Me'));
      await tester.pump();

      // Assert
      expect(buttonPressed, isTrue);
    });

    testWidgets('uses theme styles for title, content, and button',
        (WidgetTester tester) async {
      // Arrange
      const testTitle = 'Styled Title';
      const testMessage = 'Styled Message';
      const testButtonText = 'Styled Button';

      final testTheme = ThemeData(
        primaryColorLight: Colors.blue,
        primaryColorDark: Colors.black,
      );

      await tester.pumpWidget(
        MaterialApp(
          theme: testTheme,
          home: MyAlertDialog(
            title: testTitle,
            errorMessage: testMessage,
            buttonText: testButtonText,
            onPressed: () {},
          ),
        ),
      );

      // Act
      final title = find.text(testTitle);
      final message = find.text(testMessage);

      // Assert
      final titleStyle = tester.widget<Text>(title).style!;
      expect(titleStyle.color, testTheme.primaryColorDark);
      expect(titleStyle.fontWeight, FontWeight.bold);
      expect(titleStyle.fontFamily, "Noto Sans");

      final messageStyle = tester.widget<Text>(message).style!;
      expect(messageStyle.color, testTheme.primaryColorDark);
      expect(messageStyle.fontSize, 16);
    });
  });
}
