import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_talk_app/core/theming/app_colors.dart';

import '../../../../core/helpers/spacing.dart';
import '../../logic/theme_cubit/theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                verticalSpace(20),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hisham Esam',
                                style: TextStyle(
                                  color: isDarkMode ? Colors.white : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Edit personal details',
                                style: TextStyle(
                                  color: isDarkMode ? Colors.white60 : Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
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
                ),
                const SizedBox(height: 20),

                // Dark Mode Toggle Row
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDarkMode
                              ? Colors.white.withValues(alpha: 0.1)
                              : Colors.black,
                        ),
                        child: const Icon(
                          Icons.dark_mode,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Dark Mode',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Transform.scale(
                        scale: 0.85,
                        child: Switch(
                          value: isDarkMode,
                          onChanged: (value) {
                            context.read<ThemeCubit>().setTheme(value);
                          },
                          activeColor: isDarkMode ? Colors.black : AppColors.white,
                          activeTrackColor: isDarkMode ? AppColors.white : AppColors.black,
                          inactiveThumbColor: AppColors.white,
                          inactiveTrackColor: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                // Profile Section Header
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 12),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ),
                _buildSettingItem(
                  icon: Icons.person_outline,
                  iconColor: Colors.orange,
                  title: 'Edit Profile',
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(height: 12),
                _buildSettingItem(
                  icon: Icons.lock_outline,
                  iconColor: Colors.blue,
                  title: 'Change Password',
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(height: 25),

                // Regional Section Header
                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 12),
                  child: Text(
                    'Regional',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ),
                _buildSettingItem(
                  icon: Icons.language,
                  iconColor: const Color(0xFF6C5CE7),
                  title: 'Language',
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(height: 12),
                _buildSettingItem(
                  icon: Icons.logout,
                  iconColor: Colors.orange,
                  title: 'Logout',
                  isDarkMode: isDarkMode,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required bool isDarkMode,
  }) {
    return InkWell(
      onTap: () {},
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