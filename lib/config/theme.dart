import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    primaryColor: const Color(0xFFf3606e),
    textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
  );
}
