import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk_app/features/main_screen/logic/theme_cubit/theme_cubit.dart';
import 'package:free_talk_app/free_talk_app.dart';

import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  runApp(BlocProvider(
    create: (context) => ThemeCubit(),
    child: FreeTalkApp(appRouter: AppRouter(),),
  ));
}