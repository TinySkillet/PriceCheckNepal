import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:price_check_np/pages/home_page.dart';
import 'package:price_check_np/pages/landing_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //  if user is logged in
          if (snapshot.hasData) {
            return HomePage(); // redirect to home page
          } else {
            return const LandingPage(); // else direct user to the landing page
          }
        },
      ),
    );
  }
}
