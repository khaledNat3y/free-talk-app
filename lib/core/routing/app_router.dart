import 'package:flutter/material.dart';
import 'package:free_talk_app/core/routing/routes.dart';
import 'package:free_talk_app/features/main_screen/ui/main_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    // this arguments to be passed in any screen like this (arguments as ClassName)
    final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.mainScreen:
        return MaterialPageRoute(
          builder: (context) => const MainScreen(),
        );
      default:
        return null;
    }
  }
}