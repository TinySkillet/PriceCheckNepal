import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:price_check_np/auth/auth_service.dart';
import 'package:price_check_np/components/appbar.dart';
import 'package:price_check_np/components/button.dart';
import 'package:price_check_np/components/textfield.dart';
import 'package:price_check_np/components/tile.dart';
import 'package:price_check_np/utils/utils.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void loginWithGoogle(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithGoogle();
      Utils.handleSuccessfulLogin(context);
    } catch (e) {
      Utils.showErrorDialog(
          context, "Error", "An error occurred: ${e.toString()}");
    }
  }

  void signup(BuildContext context) async {
    // if email and password are empty
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      Utils.showErrorDialog(
        context,
        "Error",
        "Please enter both email and password!",
      );
      return;
    }
    // if passwords do not match
    if (_passwordController.text.trim() !=
        _confirmPasswordController.text.trim()) {
      Utils.showErrorDialog(
        context,
        "Error",
        "Passwords do not match!",
      );
      return;
    }
    final authService = AuthService();
    try {
      // attempt to register
      await authService.register(
          _emailController.text.trim(), _passwordController.text.trim());

      Utils.handleSuccessfulRegister(context);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Invalid email! Please enter a valid email address.';
          break;
        case "email-already-in-use":
          errorMessage = "An account with that email already exists!";
          break;
        case "operation-not-allowed":
          errorMessage = "Your account has been disabled!";
          break;
        case "weak-password":
          errorMessage =
              "Weak password! Please enter a strong password (combination of letters, numbers and symbols)";
        case 'too-many-requests':
          errorMessage = 'Too many requests! Please try again later!';
          break;
        case 'network-request-failed':
          errorMessage =
              'Network error! Please check your internet connection.';
          break;
        default:
          errorMessage = 'An unexpected error occurred: ${e.code}';
      }
      Utils.showErrorDialog(context, "Signup Failed!", errorMessage);
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
        isBackBtnRequired: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.only(left: 50),
              child: Text(
                "Signup",
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
            Container(
              padding: const EdgeInsets.only(left: 50),
              child: Text(
                "Just some details to get you in!",
                style: TextStyle(
                  fontFamily: "Noto Sans",
                  fontSize: 16,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),

            const SizedBox(
              height: 40,
            ),
            // full name field
            MyTextField(
              controller: _emailController,
              hintText: "Email",
              obsecureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: _passwordController,
              hintText: "Password",
              obsecureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: _confirmPasswordController,
              hintText: "Confirm password",
              obsecureText: true,
            ),
            const SizedBox(
              height: 30,
            ),
            MyButton(
              onPressed: () => signup(context),
              buttontext: "Signup",
            ),
            const SizedBox(
              height: 30,
            ),
            MyButton(
              onPressed: () {
                loginWithGoogle(context);
              },
              buttontext: "Continue with Google",
              buttonicon: Image.asset(
                "assets/images/google_icon.png",
                height: 22,
                width: 22,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?  ",
                  style: TextStyle(
                    fontFamily: "Noto Sans",
                    fontSize: 14,
                    color: Theme.of(context).primaryColorDark,
                  ),
                ),
                MyTile(
                  tiletext: "Login",
                  onPressed: () {
                    context.push(
                      '/login',
                    );
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
