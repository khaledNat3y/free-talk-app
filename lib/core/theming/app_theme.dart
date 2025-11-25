import 'package:flutter/material.dart';
import 'package:free_talk_app/core/theming/app_text_theme.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightMode = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: "LeagueSpartan",
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundLight,
    textTheme: TextTheme(
      displayLarge: AppTextTheme.font32BlackRegular,
      displayMedium: AppTextTheme.font13BlackRegular,
      displaySmall: AppTextTheme.font16BlackRegular,
    ),

  );

  static ThemeData darkMode = ThemeData(
    fontFamily: "LeagueSpartan",
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundDark,
    textTheme: TextTheme(
      displayLarge: AppTextTheme.font32BlackRegular.copyWith(color: AppColors.white),
      displayMedium: AppTextTheme.font13BlackRegular.copyWith(color: AppColors.white),
      displaySmall: AppTextTheme.font16BlackRegular.copyWith(color: AppColors.white),
    ),

  );
}