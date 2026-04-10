import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      foregroundColor: AppColors.white,
    ),
    textTheme: TextTheme(
      // Display styles
      displayLarge: GoogleFonts.balooThambi2(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      displayMedium: GoogleFonts.balooThambi2(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      displaySmall: GoogleFonts.balooThambi2(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),

      // Headline styles
      headlineLarge: GoogleFonts.balooThambi2(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      headlineMedium: GoogleFonts.balooThambi2(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      headlineSmall: GoogleFonts.balooThambi2(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),

      // Title styles
      titleLarge: GoogleFonts.balooThambi2(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      titleMedium: GoogleFonts.balooThambi2(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      titleSmall: GoogleFonts.balooThambi2(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),

      // Label styles
      labelLarge: GoogleFonts.balooThambi2(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      labelMedium: GoogleFonts.balooThambi2(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      labelSmall: GoogleFonts.balooThambi2(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),

      // Body styles
      bodyLarge: GoogleFonts.balooThambi2(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      bodyMedium: GoogleFonts.balooThambi2(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      bodySmall: GoogleFonts.balooThambi2(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        textStyle: GoogleFonts.balooThambi2(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: AppColors.white.withValues(alpha: .08),
      prefixIconColor: AppColors.white,
      suffixIconColor: AppColors.white,
      labelStyle: GoogleFonts.balooThambi2(color: AppColors.white),
      hintStyle: GoogleFonts.balooThambi2(color: AppColors.white),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: AppColors.white, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: AppColors.white.withValues(alpha: .5),
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: AppColors.white, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    ),
  );
}
