import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk_app/core/theming/app_theme.dart';
import 'package:free_talk_app/features/main_screen/ui/main_screen.dart';

class FreeTalkApp extends StatelessWidget {
  const FreeTalkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Sign Language App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightMode,
          themeMode: ThemeMode.light,
          home: const MainScreen(),
        );
      },
    );
  }
}

