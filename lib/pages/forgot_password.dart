import 'package:flutter/material.dart';
import 'package:price_check_np/components/appbar.dart';
import 'package:price_check_np/components/button.dart';
import 'package:price_check_np/components/textfield.dart';
import 'package:price_check_np/components/tile.dart';
import 'package:price_check_np/pages/register_page.dart';
import 'package:price_check_np/pages/send_code.dart';

class ForgotPaswordPage extends StatelessWidget {
  ForgotPaswordPage({super.key});

  final TextEditingController _emailController = TextEditingController();

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
                "Please enter your email address to \nget the verification code!",
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SendCodePage()),
                );
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
