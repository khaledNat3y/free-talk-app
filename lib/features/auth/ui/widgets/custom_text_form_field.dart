import 'package:flutter/material.dart';
import 'package:free_talk_app/core/theming/app_colors.dart';
import '../../../../core/theming/font_weight_helper.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key,required this.validators,required this.hintText, required this.controller, this.obscureText, this.suffixIcon});
  final String? Function(String?) validators;
  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator:validators,
      obscureText: obscureText ?? false,
      style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeightHelper.regular),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        suffixIcon: suffixIcon,
        border: buildOutlineInputBorder(color: AppColors.grey),
        enabledBorder: buildOutlineInputBorder(color: AppColors.grey),
        focusedBorder: buildOutlineInputBorder(color: AppColors.primary),
        errorBorder: buildOutlineInputBorder(color: AppColors.error),
      ),

    );
  }

  OutlineInputBorder buildOutlineInputBorder({Color? color}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: color ?? AppColors.black),
      );
  }
}