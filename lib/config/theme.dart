import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildTheme(ColorScheme colorScheme) {
  var baseTheme = ThemeData.from(
    colorScheme: colorScheme,
    useMaterial3: false,
  ).copyWith(
    primaryColor: const Color(0xFFf3606e),
  );

  return baseTheme.copyWith(
    primaryColor: const Color(0xFFf3606e),
    textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
    scaffoldBackgroundColor: Colors.white,
    buttonTheme: baseTheme.buttonTheme.copyWith(
      buttonColor: const Color(0xFFf3606e),
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}
