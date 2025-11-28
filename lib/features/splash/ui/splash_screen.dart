import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_talk_app/core/helpers/extensions.dart';
import 'package:free_talk_app/core/helpers/spacing.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/app_colors.dart';
import '../../auth/ui/widgets/custom_button.dart';
import '../../main_screen/logic/theme_cubit/theme_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return Scaffold(
          backgroundColor: isDarkMode ? AppColors.scaffoldBackgroundDark : AppColors.primary,
          body: SafeArea(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    verticalSpace(screenHeight * 0.12),
                    const Text(
                      'Free Talk',
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'It was never more easy',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    const Image(
                      image: AssetImage('assets/images/Rectangle 13.png'),
                      width: 300,
                      height: 340,
                    ),
                    verticalSpace(screenHeight * 0.05),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.22),
                      child: CustomButton(
                        isDarkMode: isDarkMode,
                        title: 'Start',
                        color: isDarkMode ? AppColors.white : AppColors.black,
                        onTap: () {
                          context.pushReplacementNamed(Routes.onboardingScreen);
                        },
                      ),
                    ),
                  ],
                ),

                Positioned(
                  top: screenHeight * 0.12,
                  left: 0,
                  child: Image(
                    image: const AssetImage('assets/images/Rectangle 14.png'),
                    width: screenWidth * 0.28,
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.24,
                  left: -4,
                  child: Image(
                    image: const AssetImage('assets/images/Rectangle 15.png'),
                    width: screenWidth * 0.28,
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.37,
                  left: -8,
                  child: Image(
                    image: const AssetImage('assets/images/Rectangle 16.png'),
                    width: screenWidth * 0.28,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
