import 'package:flutter/material.dart';
import '../app_colors.dart';

extension ThemeExtension on BuildContext {
  Color get primary {
    return Theme.of(this).brightness == Brightness.light
        ? AppColors.lightPrimary
        : AppColors.darkPrimary;
  }

  Color get secondary {
    return Theme.of(this).brightness == Brightness.light
        ? AppColors.lightSecondary
        : AppColors.darkSecondary;
  }

  Color get accent {
    return Theme.of(this).brightness == Brightness.light
        ? AppColors.lightAccent
        : AppColors.darkAccent;
  }

  Color get bg1 {
    return Theme.of(this).brightness == Brightness.light
        ? AppColors.lightBg1
        : AppColors.darkBg1;
  }

  Color get bg2 {
    return Theme.of(this).brightness == Brightness.light
        ? AppColors.lightBg2
        : AppColors.darkBg2;
  }

  Color get bg3 {
    return Theme.of(this).brightness == Brightness.light
        ? AppColors.lightBg3
        : AppColors.darkBg3;
  }

  Color get textColor1 {
    return Theme.of(this).brightness == Brightness.light
        ? AppColors.lightText1
        : AppColors.darkText1;
  }

  Color get textColor2 {
    return Theme.of(this).brightness == Brightness.light
        ? AppColors.lightText2
        : AppColors.darkText2;
  }

  Color get textColor3 {
    return Theme.of(this).brightness == Brightness.light
        ? AppColors.lightText3
        : AppColors.darkText3;
  }
}
