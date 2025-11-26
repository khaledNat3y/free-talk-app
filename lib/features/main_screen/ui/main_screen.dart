import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk_app/features/main_screen/ui/screens/account_screen.dart';
import 'package:free_talk_app/features/main_screen/ui/screens/dictionary_screen.dart';
import 'package:free_talk_app/features/main_screen/ui/screens/settings_screen.dart';
import 'package:free_talk_app/features/main_screen/ui/screens/translate_screen.dart';
import '../../../core/theming/app_colors.dart';
import '../logic/theme_cubit/theme_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        final List<Widget> screens = [
          TranslateScreen(isDarkMode: isDarkMode,),
          DictionaryScreen(isDarkMode: isDarkMode,),
          const AccountScreen(),
          const SettingsScreen(),
        ];

        return Scaffold(
          backgroundColor: isDarkMode ? AppColors.scaffoldBackgroundDark : AppColors.scaffoldBackgroundLight,
          body: SafeArea(child: screens.elementAt(_currentIndex)),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: isDarkMode?AppColors.primaryDark : AppColors.primary,
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
              color: isDarkMode ? AppColors.scaffoldBackgroundDark : AppColors.scaffoldBackgroundLight,

            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      icon: Icons.translate_rounded,
                      label: 'Translate',
                      index: 0,
                      isDarkMode: isDarkMode,
                    ),
                    _buildNavItem(
                      icon: Icons.book,
                      label: 'Dictionary',
                      index: 1,
                      isDarkMode: isDarkMode,
                    ),
                    _buildNavItem(
                      icon: Icons.person,
                      label: 'Account',
                      index: 2,
                      isDarkMode: isDarkMode,
                    ),
                    _buildNavItem(
                      icon: Icons.settings,
                      label: 'Settings',
                      index: 3,
                      isDarkMode: isDarkMode,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    bool isDarkMode = false,
  }) {
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
              color: isSelected ? isDarkMode ? AppColors.primaryDark : AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : isDarkMode ? AppColors.primaryDark : AppColors.primary,
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