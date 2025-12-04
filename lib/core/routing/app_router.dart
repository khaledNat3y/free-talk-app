import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_talk_app/core/di/di.dart';
import 'package:free_talk_app/core/routing/routes.dart';
import 'package:free_talk_app/core/services/firebase_service.dart';
import 'package:free_talk_app/features/auth/data/repo/auth_repo.dart';
import 'package:free_talk_app/features/auth/logic/auth_cubit.dart';
import 'package:free_talk_app/features/auth/ui/login_screen.dart';
import 'package:free_talk_app/features/auth/ui/signup_screen.dart';
import 'package:free_talk_app/features/main_screen/ui/main_screen.dart';
import 'package:free_talk_app/features/main_screen/ui/screens/supported_languages_screen.dart';
import 'package:free_talk_app/features/onboarding/ui/onboarding_screen.dart';
import 'package:free_talk_app/features/splash/ui/splash_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    // this arguments to be passed in any screen like this (arguments as ClassName)
    final _ = settings.arguments;
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(
                create: (context) =>
                    AuthCubit(AuthRepo()),
                child: const LoginScreen(),
              ),
        );
      case Routes.signupScreen:
        return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(
                create: (context) =>
                    getIt<AuthCubit>(),
                child: const SignupScreen(),
              ),
        );
      case Routes.mainScreen:
        return MaterialPageRoute(
          builder: (context) =>
              BlocProvider(
                create: (context) => getIt<AuthCubit>(),
                child: const MainScreen(),
              ),
        );
      case Routes.languageScreen:
        return MaterialPageRoute(
          builder: (context) => const SupportedLanguagesScreen(),
        );
      case Routes.onboardingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        );
      default:
        return null;
    }
  }
}