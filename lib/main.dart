import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/services/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:myapp/router.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp.router(
      routerConfig: router,
      title: 'Photo Cleaner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.oswald(textStyle: textTheme.bodyMedium),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme).copyWith(
          bodyMedium: GoogleFonts.oswald(textStyle: ThemeData.dark().textTheme.bodyMedium),
        ),
      ),
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
    );
  }
}
