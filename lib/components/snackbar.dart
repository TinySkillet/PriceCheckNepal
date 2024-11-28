import 'package:flutter/material.dart';

class MySnackbar extends SnackBar {
  MySnackbar({
    super.key,
    required String message,
  }) : super(
          content: Text(
            message,
            style: const TextStyle(
              fontFamily: "Noto Sans",
              fontSize: 16,
            ),
          ),
          backgroundColor: Colors.black, // Replace with your desired color
          showCloseIcon: true,
          closeIconColor: Colors.white, // Replace with your desired color
        );
}
