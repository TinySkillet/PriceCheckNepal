import 'package:flutter/material.dart';
import 'package:price_check_np/components/appbar.dart';
import 'package:price_check_np/components/button.dart';
import 'package:price_check_np/components/textfield.dart';
import 'package:price_check_np/components/tile.dart';
import 'package:price_check_np/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: const MyAppBar(
        isBackBtnRequired: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            height: 50,
          ),
          // full name field
          MyTextField(
            controller: _fullNameController,
            hintText: "Full Name",
            obsecureText: false,
          ),
          const SizedBox(
            height: 20,
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
            onPressed: () {},
            buttontext: "Signup",
          ),
          const SizedBox(
            height: 30,
          ),
          MyButton(
            onPressed: () {},
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
