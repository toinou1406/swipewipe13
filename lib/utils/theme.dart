
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF000000),
    primaryColor: const Color(0xFF000000),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFFFFFFF),
      secondary: Color(0xFF808080),
      surface: Color(0xFF333333),
      onPrimary: Color(0xFF000000),
      onSecondary: Color(0xFFFFFFFF),
      onSurface: Color(0xFFFFFFFF),
      error: Color(0xFF808080), // Using grey for error to maintain B&W
      onError: Color(0xFFFFFFFF),
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFFFFFFFF)),
      bodyLarge: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.normal, color: const Color(0xFFFFFFFF)),
      bodyMedium: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.normal, color: const Color(0xFF808080)),
    ),
    iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF000000),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFFFFF),
        foregroundColor: const Color(0xFF000000),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF808080),
        side: const BorderSide(color: Color(0xFF333333)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color(0xFFFFFFFF),
      linearTrackColor: Color(0xFF333333),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: const TextStyle(color: Color(0xFFFFFFFF)),
    ),
  );
}
