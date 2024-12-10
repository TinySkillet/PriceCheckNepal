import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String errorMessage;
  final String title;
  final String buttonText;
  final void Function()? onPressed;

  const MyAlertDialog({
    super.key,
    required this.title,
    required this.errorMessage,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).primaryColorLight,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
          fontWeight: FontWeight.bold,
          fontFamily: "Noto Sans",
        ),
      ),
      content: Text(
        errorMessage,
        style: TextStyle(
          color: Theme.of(context).primaryColorDark,
          fontSize: 16,
        ),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
              textStyle: const WidgetStatePropertyAll(TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
              foregroundColor:
                  WidgetStatePropertyAll(Theme.of(context).primaryColorLight),
              backgroundColor:
                  WidgetStatePropertyAll(Theme.of(context).primaryColorDark)),
          onPressed: onPressed,
          child: Text(buttonText),
        )
      ],
    );
  }
}
