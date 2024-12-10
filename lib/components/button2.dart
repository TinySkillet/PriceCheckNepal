import 'package:flutter/material.dart';

class LightButton extends StatelessWidget {
  final Function() onPressed;
  final String buttontext;
  final bool? isEnabled;
  const LightButton({
    super.key,
    required this.onPressed,
    required this.buttontext,
    this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: (isEnabled ?? false)
              ? const WidgetStatePropertyAll<Color>(
                  Colors.redAccent,
                )
              : WidgetStatePropertyAll<Color>(
                  Theme.of(context).primaryColorLight,
                ),
          padding:
              const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12)),
          side: WidgetStatePropertyAll<BorderSide>(
            BorderSide(
              color: Theme.of(context).primaryColorDark,
              width: 1.0,
            ),
          ),
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttontext,
          style: TextStyle(
            color: (isEnabled ?? false)
                ? Theme.of(context).primaryColorLight
                : Theme.of(context).primaryColorDark,
            fontFamily: "Noto Sans",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
