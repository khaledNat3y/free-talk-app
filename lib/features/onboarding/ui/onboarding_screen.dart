import 'package:flutter/material.dart';
import 'package:free_talk_app/core/helpers/constants.dart';
import 'package:free_talk_app/core/helpers/extensions.dart';
import 'package:free_talk_app/core/helpers/spacing.dart';
import 'package:free_talk_app/features/onboarding/ui/widgets/onboarding_page.dart';
import '../../../core/helpers/shared_pref_helper.dart';
import '../../../core/routing/routes.dart';
import '../../auth/ui/widgets/next_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  void nextPage(){
    if (currentPage < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      userFirstTimeCheck();
      context.pushReplacementNamed(Routes.loginScreen);
    }
  }

  Future<void> userFirstTimeCheck() async {
    await SharedPrefHelper.setData("isFirstTime", isFirstTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (value) {
                  setState(() => currentPage = value);
                },
                children: const [
                  OnboardingPage(
                    title: 'Hello',
                    description:
                    'Hello, I am mick  Hand talk virtual sign language translator and I am here to help you',
                  ),
                  OnboardingPage(
                    title: 'About the apps',
                    description:
                    'Globally awarded, the Hand talk app assists in learning and understanding sign language through AI. Supports English, Arabic & French.',
                  ),
                  OnboardingPage(
                    title: 'Connect Effortlessly',
                    description:
                    'The app uses AI to translate. It improves with sentences, contexts & feedback. Sometimes translations might not be perfect.',
                  ),
                ],
              ),
            ),

            /// Next button
            NextButton(onTap: nextPage),

            verticalSpace(30),
          ],
        ),
      ),
    );
  }
}
