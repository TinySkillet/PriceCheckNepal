import 'package:flutter/material.dart';
import 'package:price_check_np/pages/login_page.dart';
// import 'package:price_check_np/pages/login_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColorDark,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 20,
                right: 5,
              ),
              child: Image.asset(
                './assets/images/landing_img.png',
                height: MediaQuery.of(context).size.height * 0.7,
                isAntiAlias: true,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 60),
                    child: Text(
                      "\"Your Smart Laptop Price Comparison Tool\"",
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontFamily: "Kadwa",
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Compare and Save on the Best Laptop Deals!",
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontFamily: "Kadwa",
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextButton.icon(
                    iconAlignment: IconAlignment.end,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    label: Text(
                      "Get Started",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorLight,
                        fontFamily: "Kadwa",
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    icon: Icon(
                      Icons.arrow_right_alt_rounded,
                      size: 40,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
