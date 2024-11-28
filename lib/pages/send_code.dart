import 'package:flutter/material.dart';
import 'package:price_check_np/components/appbar.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:price_check_np/pages/new_password.dart';

class SendCodePage extends StatelessWidget {
  const SendCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: const MyAppBar(
        isBackBtnRequired: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            padding: const EdgeInsets.only(left: 50),
            child: Text(
              "We Sent You a Code",
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
          Container(
            padding: const EdgeInsets.only(left: 50),
            child: Text(
              "Verify your email with the 4 digit code \nwe sent to your email!",
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
          OtpTextField(
            clearText: true,
            margin: const EdgeInsets.only(right: 13),
            mainAxisAlignment: MainAxisAlignment.center,
            enabledBorderColor: Theme.of(context).indicatorColor,
            focusedBorderColor: Theme.of(context).primaryColorDark,
            borderRadius: BorderRadius.circular(20),
            filled: true,
            fieldWidth: 65,
            fieldHeight: 150,
            autoFocus: true,
            textStyle: TextStyle(
              fontFamily: "Noto Sans",
              fontSize: 26,
              color: Theme.of(context).primaryColorDark,
              fontWeight: FontWeight.bold,
            ),
            numberOfFields: 4,
            cursorColor: Theme.of(context).indicatorColor,
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SetNewPasswordPage()),
              );
            }, // end onSubmit
          )
        ],
      ),
    );
  }
}
