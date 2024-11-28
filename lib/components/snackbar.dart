import 'package:flutter/material.dart';

class MySnackbar extends SnackBar {
  MySnackbar({
    super.key,
    required String message,
  }) : super(
          duration: const Duration(seconds: 1),
          content: Text(
            message,
            style: const TextStyle(
              fontFamily: "Noto Sans",
              fontSize: 16,
            ),
          ),
          backgroundColor: const Color.fromRGBO(
              93, 88, 88, 1.0), // Replace with your desired color
          showCloseIcon: true,
          closeIconColor: Colors.white, // Replace with your desired color
        );
}
