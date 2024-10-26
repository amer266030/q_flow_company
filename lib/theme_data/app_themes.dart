import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  // Light Theme
  static final lightTheme = ThemeData(
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightBg1,
    appBarTheme: const AppBarTheme(color: AppColors.lightBg1),
    fontFamily: 'Inter',
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontSize: 12, color: AppColors.lightText3),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.lightText2),
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.lightText1),
      titleSmall: TextStyle(
          fontSize: 20,
          color: AppColors.lightText1,
          height: 1,
          fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
          fontSize: 28,
          color: AppColors.lightText1,
          height: 1,
          fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          fontSize: 34,
          color: AppColors.lightText1,
          height: 1,
          fontWeight: FontWeight.w500),
    ),
    brightness: Brightness.light,
  );

  // Dark Theme
  static final darkTheme = ThemeData(
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBg1,
    appBarTheme: const AppBarTheme(color: AppColors.darkBg1),
    fontFamily: 'Inter',
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontSize: 12, color: AppColors.darkText3),
      bodyMedium: TextStyle(fontSize: 14, color: AppColors.darkText2),
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.darkText1),
      titleSmall: TextStyle(
          fontSize: 20,
          color: AppColors.darkText1,
          height: 1,
          fontWeight: FontWeight.bold),
      titleMedium: TextStyle(
          fontSize: 28,
          color: AppColors.darkText1,
          height: 1,
          fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          fontSize: 34,
          color: AppColors.darkText1,
          height: 1,
          fontWeight: FontWeight.w500),
    ),
    brightness: Brightness.dark,
  );
}
