import 'package:flutter/material.dart';
import 'package:free_talk_app/core/helpers/extensions.dart';
import 'package:free_talk_app/core/helpers/spacing.dart';

import '../theming/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  final bool isDarkMode;
  const CustomBackButton({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => context.pop(),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: isDarkMode ? AppColors.white : AppColors.black, width: 2),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_back, size: 20, color: isDarkMode ? AppColors.white : AppColors.black,),
          horizontalSpace(8),
          Text(
            "Back",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ],
      ),
    )
    ;
  }
}
