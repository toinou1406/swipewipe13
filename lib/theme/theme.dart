import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF000000),
    scaffoldBackgroundColor: const Color(0xFF000000),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFF808080), fontSize: 14),
    ),
    iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFFFFFFFF),
      textTheme: ButtonTextTheme.primary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF000000),
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
    ),
  );
}
