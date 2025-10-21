import 'package:flutter/material.dart';
import 'package:sparkle/utils/theme.dart';
import 'package:sparkle/utils/router.dart';

void main() {
  runApp(const SparkleApp());
}

class SparkleApp extends StatelessWidget {
  const SparkleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Sparkle',
      theme: darkTheme,
    );
  }
}
