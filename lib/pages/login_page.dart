import 'package:flutter/material.dart';
import 'package:price_check_np/components/appbar.dart';
import 'package:price_check_np/components/textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // email and pw text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: const MyAppBar(
        isBackBtnRequired: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //  title text
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
          // title sub text
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
          // email text field
          MyTextField(
            controller: _emailController,
            hintText: "Email",
            obsecureText: false,
          ),
          const SizedBox(
            height: 10,
          ),
          // password text field
          MyTextField(
            controller: _passwordController,
            hintText: "Password",
            obsecureText: true,
          ),
        ],
      ),
    );
  }
}
