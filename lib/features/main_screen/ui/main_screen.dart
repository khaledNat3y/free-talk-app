import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk_app/features/main_screen/ui/screens/account_screen.dart';
import 'package:free_talk_app/features/main_screen/ui/screens/dictionary_screen.dart';
import 'package:free_talk_app/features/main_screen/ui/screens/settings_screen.dart';
import 'package:free_talk_app/features/main_screen/ui/screens/translate_screen.dart';

import '../../../core/theming/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const TranslateScreen(),
      const DictionaryScreen(),
      AccountScreen(
        isDarkMode: _isDarkMode,
        onThemeChanged: (value) {
          setState(() {
            _isDarkMode = value;
          });
        },
      ),
      SettingsScreen(
        isDarkMode: _isDarkMode,
        onThemeChanged: (value) {
          setState(() {
            _isDarkMode = value;
          });
        },
      ),
    ];

    return Scaffold(
      backgroundColor: _isDarkMode ? const Color(0xFF1A1A2E) : Colors.white,
      body: SafeArea(child: screens.elementAt(_currentIndex)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        clipBehavior: Clip.hardEdge,
        elevation: 0,
        shape: const CircleBorder(),
        tooltip: "Contact Us",
        child: Icon(
          Icons.message,
          color: AppColors.white,
          size: 32.sp,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.translate,
                  label: 'Translate',
                  index: 0,
                ),
                _buildNavItem(
                  icon: Icons.book,
                  label: 'Dictionary',
                  index: 1,
                ),
                _buildNavItem(
                  icon: Icons.person,
                  label: 'Account',
                  index: 2,
                ),
                _buildNavItem(
                  icon: Icons.settings,
                  label: 'Settings',
                  index: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required int index,}) {
    final bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 20.w),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF522AAF) : Colors.transparent,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : const Color(0xFF522AAF),
              size: 24.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}