import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  final void Function() _onPressed;
  final String tiletext;

  const MyTile({
    super.key,
    required this.tiletext,
    required void Function() onPressed,
  }) : _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressed,
      child: Text(
        tiletext,
        style: TextStyle(
          fontFamily: "Noto Sans",
          fontSize: 14,
          decoration: TextDecoration.underline,
          color: Theme.of(context).primaryColorDark,
        ),
      ),
    );
  }
}
