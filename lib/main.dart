import 'package:flutter/material.dart';
import 'package:swipe_clean/utils/theme.dart';
import 'package:swipe_clean/screens/home_screen.dart';

void main() {
  runApp(const SwipeCleanApp());
}

class SwipeCleanApp extends StatelessWidget {
  const SwipeCleanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SwipeClean',
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const HomeScreen(),
    );
  }
}
