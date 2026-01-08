import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF00509D);
  static const Color secondary = Color(0xFFFFCB05);
  static const Color darkBlue = Color(0xFF003373);
  static const Color darkYellow = Color(0xFFFFAC00);
  static const Color background = Color(0xFFE0E0DE);
}

class AppTextStyles {
  static const TextStyle sectionHeader = TextStyle(color: AppColors.darkBlue, fontSize: 28, fontWeight: FontWeight.bold,);
}

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.background,
  primaryColor: AppColors.primary,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    background: AppColors.background,
    brightness: Brightness.light,
  ),
  appBarTheme: const AppBarTheme(
    foregroundColor: Colors.white,
    backgroundColor: AppColors.primary,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.primary,
    selectedItemColor: AppColors.secondary,
    unselectedItemColor: Colors.white,
    type: BottomNavigationBarType.fixed,
  ),
);
