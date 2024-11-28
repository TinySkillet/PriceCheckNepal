import 'package:flutter/material.dart';
import 'package:price_check_np/auth/auth_service.dart';
import 'package:price_check_np/components/appbar.dart';
import 'package:price_check_np/components/button.dart';
import 'package:price_check_np/components/snackbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        isBackBtnRequired: false,
        title: "Home Page",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyButton(
            onPressed: () {
              Navigator.pop(context);
              logout();
              ScaffoldMessenger.of(context).showSnackBar(
                  MySnackbar(message: "Logged out successfully!"));
            },
            buttontext: "Logout",
          ),
        ],
      ),
    );
  }
}
