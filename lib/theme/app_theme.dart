// lib/theme/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  // To change the theme, just change this seed color.
  static const Color _seedColor = Colors.deepPurple;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      // Define the brightness and colors.
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
      ),
      // Define the default app bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: ColorScheme.fromSeed(seedColor: _seedColor).primary,
        foregroundColor: ColorScheme.fromSeed(seedColor: _seedColor).onPrimary,
      ),
      // Define the default floating action button theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorScheme.fromSeed(seedColor: _seedColor).primary,
        foregroundColor: ColorScheme.fromSeed(seedColor: _seedColor).onPrimary,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
      ),
    );
  }
}