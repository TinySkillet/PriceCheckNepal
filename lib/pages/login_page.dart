import 'package:flutter/material.dart';
import 'package:price_check_np/components/appbar.dart';
import 'package:price_check_np/components/button.dart';
import 'package:price_check_np/components/textfield.dart';
import 'package:price_check_np/components/tile.dart';
import 'package:price_check_np/pages/forgot_password.dart';
import 'package:price_check_np/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // email and password text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isRemembered = false; // the state of the checkbox

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
            // Title text
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.only(left: 50),
              child: Text(
                "Login",
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
                "Glad you're back!",
                style: TextStyle(
                  fontFamily: "Noto Sans",
                  fontSize: 16,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // Email text field
            MyTextField(
              controller: _emailController,
              hintText: "Email",
              obsecureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            // Password text field
            MyTextField(
              controller: _passwordController,
              hintText: "Password",
              obsecureText: true,
            ),
            const SizedBox(
              height: 15,
            ),
            // Remember Me checkbox
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: isRemembered,
                    splashRadius: 10.0,
                    activeColor: Theme.of(context).primaryColorDark,
                    checkColor: Theme.of(context).primaryColorLight,
                    onChanged: (bool? value) {
                      setState(() {
                        isRemembered = value ?? false;
                      });
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isRemembered = !isRemembered;
                      });
                    },
                    child: const Text(
                      "Remember Me",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: "Noto Sans",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // login button
            MyButton(
              onPressed: () {},
              buttontext: "Login",
            ),
            const SizedBox(
              height: 5,
            ),
            // Forgot password row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgotPaswordPage()),
                    );
                  },
                  label: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 5,
            ),
            // continue with google button
            MyButton(
              onPressed: () {},
              buttontext: "Continue with Google",
              buttonicon: Image.asset(
                "assets/images/google_icon.png",
                height: 22,
                width: 22,
              ),
            ),
            // dont have an account row
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
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPage()),
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
