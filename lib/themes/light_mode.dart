import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme.light(
    // background color
    surface: Colors.white,

    // text, button color
    primary: Colors.black,

    // color of text inside button
    secondary: Colors.white,

    // color for landing page background
    inversePrimary: Color.fromARGB(255, 27, 25, 26),

    // color of back button on appbar
    tertiary: Color.fromARGB(255, 93, 88, 88),
  ),
);
