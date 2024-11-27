import 'package:flutter/material.dart';
import 'package:price_check_np/pages/landing_page.dart';
import 'package:price_check_np/themes/light_mode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LandingPage(),
      theme: lightMode,
    );
  }
}
