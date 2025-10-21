
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sparkle/screens/albums_screen.dart';
import 'package:sparkle/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sparkle',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kPrimaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: kAccentColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: kAccentColor),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: kAccentColor),
          bodyMedium: TextStyle(color: kAccentColor),
        ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColor),
      ),
      home: const AlbumsScreen(),
    );
  }
}
