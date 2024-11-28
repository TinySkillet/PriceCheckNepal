import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function() _onPressed;
  final String buttontext;
  final Image? buttonicon;

  const MyButton({
    super.key,
    required void Function() onPressed,
    required this.buttontext,
    this.buttonicon,
  }) : _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextButton.icon(
        iconAlignment: IconAlignment.start,
        onPressed: _onPressed,
        style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColorDark,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(12), // Specify border radius here
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            )),
        label: Text(
          buttontext,
          maxLines: 1,
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            backgroundColor: Theme.of(context).primaryColorDark,
            fontFamily: "Noto Sans",
          ),
        ),
        icon: buttonicon,
      ),
    );
  }
}
