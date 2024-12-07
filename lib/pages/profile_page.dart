import 'package:flutter/material.dart';
import 'package:price_check_np/auth/auth_service.dart';
import 'package:price_check_np/components/button.dart';
import 'package:price_check_np/components/snackbar.dart';
import 'package:price_check_np/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyButton(
            onPressed: () {
              logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                MySnackbar(message: "Logged out successfully!"),
              );
            },
            buttontext: "Logout",
          ),
        ],
      ),
    );
  }
}
