import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:price_check_np/auth/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: ThemeData(
        // background color
        primaryColorLight: Colors.white,
        scaffoldBackgroundColor: Colors.white,

        // text, button color
        primaryColorDark: Colors.black,

        // appbar back button color
        indicatorColor: const Color.fromRGBO(93, 88, 88, 1.0),
      ),
    );
  }
}
