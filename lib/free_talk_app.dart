import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk_app/core/routing/app_router.dart';
import 'package:free_talk_app/core/theming/app_theme.dart';
import 'package:free_talk_app/features/main_screen/ui/main_screen.dart';

import 'features/main_screen/logic/theme_cubit/theme_cubit.dart';

class FreeTalkApp extends StatelessWidget {
  final AppRouter appRouter;
  const FreeTalkApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<ThemeCubit, bool>(
          builder: (context, isDarkMode) {
            return MaterialApp(
              title: 'Sign Language App',
              debugShowCheckedModeBanner: false,
              theme: isDarkMode ? AppTheme.darkMode : AppTheme.lightMode,
              themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
              onGenerateRoute: appRouter.generateRoute,
            );
          },
        );
      },
    );
  }
}


