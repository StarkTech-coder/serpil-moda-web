import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Renk Paleti - Serpil Moda Evi Luxury Concept
  static const Color gold = Color(0xFFC5A059);
  static const Color darkGold = Color(0xFF9E7E38);
  static const Color background = Color(0xFF0A0A0A);
  static const Color surface = Color(0xFF161616);
  static const Color textLight = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFFA0A0A0);

  static ThemeData get luxuryTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        primary: gold,
        secondary: darkGold,
        surface: surface,
        onSurface: textLight,
        outline: gold,
      ),
      textTheme: TextTheme(
        // Başlıklar için zarif Playfair Display
        displayLarge: GoogleFonts.playfairDisplay(
          fontSize: 72,
          fontWeight: FontWeight.bold,
          color: gold,
          letterSpacing: -1.5,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: textLight,
        ),
        displaySmall: GoogleFonts.playfairDisplay(
          fontSize: 32,
          fontWeight: FontWeight.w500,
          color: gold,
        ),
        // Gövde metinleri için modern Montserrat
        bodyLarge: GoogleFonts.montserrat(
          fontSize: 18,
          color: textLight,
          letterSpacing: 1.2,
        ),
        bodyMedium: GoogleFonts.montserrat(
          fontSize: 14,
          color: textSecondary,
        ),
        labelLarge: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: gold,
          letterSpacing: 2.0,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: gold),
      ),
      dividerTheme: const DividerThemeData(
        color: gold,
        thickness: 0.5,
      ),
    );
  }
}
