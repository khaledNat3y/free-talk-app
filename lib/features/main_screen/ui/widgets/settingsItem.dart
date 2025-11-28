import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final bool isDarkMode;
  final VoidCallback? onTap;

  const SettingItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.isDarkMode,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconColor.withValues(alpha: 0.15),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: isDarkMode ? Colors.white60 : Colors.black54,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}