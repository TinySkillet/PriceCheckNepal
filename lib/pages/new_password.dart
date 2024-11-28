import 'package:flutter/material.dart';
import 'package:price_check_np/components/appbar.dart';
import 'package:price_check_np/components/button.dart';
import 'package:price_check_np/components/textfield.dart';
import 'package:price_check_np/pages/password_changed.dart';

class SetNewPasswordPage extends StatelessWidget {
  SetNewPasswordPage({super.key});

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

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
                "Set a new Password",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "Noto Sans",
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
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
                "Create a new password. Ensure it \ndiffers from previous one for security!",
                style: TextStyle(
                  fontFamily: "Noto Sans",
                  fontSize: 16,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            MyTextField(
              controller: _newPasswordController,
              hintText: "New Password",
              obsecureText: true,
            ),
            const SizedBox(
              height: 30,
            ),
            MyTextField(
              controller: _confirmNewPasswordController,
              hintText: "Confirm Password",
              obsecureText: true,
            ),
            const SizedBox(
              height: 30,
            ),
            MyButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PasswordChangedSuccessPage()),
                );
              },
              buttontext: "Update Password",
            ),
          ],
        ),
      ),
    );
  }
}
