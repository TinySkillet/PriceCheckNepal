import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:price_check_np/auth/auth_service.dart';
import 'package:price_check_np/components/appbar.dart';
import 'package:price_check_np/components/button.dart';
import 'package:price_check_np/components/textfield.dart';
import 'package:price_check_np/components/tile.dart';
import 'package:price_check_np/utils/utils.dart';
import 'package:go_router/go_router.dart';

class ForgotPaswordPage extends StatelessWidget {
  ForgotPaswordPage({super.key});

  final TextEditingController _emailController = TextEditingController();

  void sendPasswordResetEmail(BuildContext context) async {
    if (_emailController.text.trim() == "") {
      Utils.showErrorDialog(
        context,
        "Error",
        "Please enter your email!",
      );
      return;
    }

    final authService = AuthService();

    try {
      await authService.sendPasswordResetEmail(_emailController.text.trim());
      context.go("/emailsent");
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'auth/invalid-email':
          errorMessage = 'Invalid email! Please enter a valid email address.';
          break;
        case 'user-not-found':
          errorMessage =
              'We could not find a user with that email address!\nPlease sign up and create an account!';
          break;
        default:
          errorMessage = 'An unexpected error occurred: ${e.code}';
      }
      Utils.showErrorDialog(context, "Error!", errorMessage);
    } catch (e) {
      Utils.showErrorDialog(
          context, "Error", "An error occurred: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: const MyAppBar(
        isBackBtnRequired: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title text
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.only(left: 50),
              child: Text(
                "Forgot \nPassword ?",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Noto Sans",
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Subtitle text
            Container(
              padding: const EdgeInsets.only(left: 50),
              child: Text(
                "If your email exists in our system, we \nwill send you a password reset link!",
                style: TextStyle(
                  fontFamily: "Noto Sans",
                  fontSize: 16,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            // Email text field
            MyTextField(
              controller: _emailController,
              hintText: "Enter Email Address",
              obsecureText: false,
            ),
            const SizedBox(height: 30),
            MyButton(
              onPressed: () {
                sendPasswordResetEmail(context);
              },
              buttontext: "Submit",
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?  ",
                  style: TextStyle(
                    fontFamily: "Noto Sans",
                    fontSize: 14,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                MyTile(
                  tiletext: "Signup",
                  onPressed: () {
                    context.go('/signup');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
