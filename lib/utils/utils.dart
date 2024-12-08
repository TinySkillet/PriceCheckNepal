import 'package:flutter/material.dart';
import 'package:price_check_np/components/alert_dialog.dart';
import 'package:price_check_np/components/snackbar.dart';
import 'package:go_router/go_router.dart';

class Utils {
  static void showErrorDialog(
    BuildContext context,
    String title,
    String message,
  ) {
    showDialog(
      context: context,
      builder: (context) => MyAlertDialog(
        title: title,
        errorMessage: message,
        buttonText: "OK",
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  static void handleSuccessfulRegister(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        MySnackbar(message: "Registered successfully! Logging you in....."));

    Future.delayed(const Duration(milliseconds: 1000), () {
      context.go("/home");
    });
  }

  static void handleSuccessfulLogin(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(MySnackbar(message: "Logged in successfully!"));
    context.go("/home");
  }
}
