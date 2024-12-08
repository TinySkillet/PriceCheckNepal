import 'package:flutter/material.dart';
import 'package:price_check_np/auth/auth_service.dart';
import 'package:price_check_np/components/appbar.dart';
import 'package:price_check_np/components/button.dart';
import 'package:price_check_np/components/snackbar.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void logout(BuildContext context) async {
    final authService = AuthService();

    try {
      // perform logout
      await authService.signOut();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).clearSnackBars();

        ScaffoldMessenger.of(context).showSnackBar(
          MySnackbar(message: "Logged out successfully!"),
        );

        // navigate to login page
        context.go('/login');
      });
    } catch (e) {
      // Handle any logout errors
      ScaffoldMessenger.of(context).showSnackBar(
        MySnackbar(message: "Logout failed: ${e.toString()}"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        isBackBtnRequired: true,
        centerTitle: true,
        title: "Profile",
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyButton(
            onPressed: () => logout(context),
            buttontext: "Logout",
          ),
        ],
      ),
    );
  }
}
