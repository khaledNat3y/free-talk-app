import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk_app/core/theming/app_colors.dart';
import 'package:free_talk_app/core/theming/app_text_theme.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isDarkMode;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key, required this.hintText, this.onChanged, required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20.w),
          hintText: hintText,
          hintFadeDuration: const Duration(milliseconds: 500),
          hintStyle: Theme.of(context).textTheme.displaySmall,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: isDarkMode ? AppColors.white : AppColors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: isDarkMode ? AppColors.white : AppColors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: isDarkMode ? AppColors.white : AppColors.black),
          ),
        ),
      ),
    );
  }
}
