import 'package:flutter/material.dart';
import 'package:price_check_np/components/button.dart';
import 'package:price_check_np/pages/login_page.dart';

class PasswordResetEmailSentSuccessPage extends StatelessWidget {
  const PasswordResetEmailSentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/check_icon.png",
                height: 70,
                width: 70,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Success!",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Noto Sans",
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                "Check your email for the password \nreset link!",
                style: TextStyle(
                  fontFamily: "Noto Sans",
                  fontSize: 16,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          MyButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            buttontext: "Continue",
          ),
        ],
      ),
    );
  }
}
