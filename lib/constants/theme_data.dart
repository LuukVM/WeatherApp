import 'package:flutter/material.dart';

class WeatherAppTheme {
  WeatherAppTheme._();

  // FAF9F7
  // E5906F
  // ABB0C2
  // A46375
  // 54485E

  static final ThemeData themeData = ThemeData(
    colorScheme: ColorScheme(
        primary: const Color(0xFF684F95),
        primaryVariant: const Color(0xFF684F95),
        secondary: const Color(0xFF823695),
        secondaryVariant: const Color(0xFF823695),
        surface: const Color(0xFFFFFFFF),
        background: const Color(0xFFE3D5FF),
        error: const Color(0xFFF33023),
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        onBackground: Colors.grey,
        onError: Colors.white,
        brightness: Brightness.light),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
      headline2: TextStyle(
        fontSize: 36.0, color: Colors.black
      ),
      bodyText1: TextStyle(fontSize: 18.0, color: Colors.white),
      subtitle1: TextStyle(
          fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.bold),
      subtitle2: TextStyle(
          fontSize: 18.0, color: Colors.black),
    ),
    iconTheme: IconThemeData(color: const Color(0xFF823695)),
  );
}
