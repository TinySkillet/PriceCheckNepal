import 'package:flutter/material.dart';
import 'package:price_check_np/pages/landing_page.dart';
// import 'package:price_check_np/themes/light_mode.dart';

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
      theme: ThemeData(
        // background color
        primaryColorLight: Colors.white,
        scaffoldBackgroundColor: Colors.white,

        // text, button color
        primaryColorDark: Colors.black,

        // appbar back button color
        indicatorColor: const Color.fromRGBO(93, 88, 88, 1.0),

        // color for landing page background
        splashColor: const Color.fromRGBO(27, 25, 26, 1.0),
      ),
    );
  }
}
