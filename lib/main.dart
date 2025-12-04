import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:free_talk_app/core/helpers/logger.dart';
import 'package:free_talk_app/core/helpers/shared_pref_helper.dart';
import 'package:free_talk_app/features/main_screen/logic/theme_cubit/theme_cubit.dart';
import 'package:free_talk_app/free_talk_app.dart';

import 'core/di/di.dart';
import 'core/helpers/constants.dart';
import 'core/routing/app_router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ScreenUtil.ensureScreenSize();
  await setupGetIt();
  await checkIfUserFirstTimeAndLoggedIn();
  Logger.debug("$isFirstTime");
  runApp(BlocProvider(
    create: (context) => ThemeCubit(),
    child: FreeTalkApp(appRouter: AppRouter(),),
  ));
}

Future<void> checkIfUserFirstTimeAndLoggedIn() async {
  final bool result = await SharedPrefHelper.getBool("isFirstTime");
  if (!result) {
    //isFirstTime = true;
    return;
  } else {
    isFirstTime = false;
    if(FirebaseAuth.instance.currentUser == null){
      isLoggedIn = false;
    }else {
      isLoggedIn = true;
    }
  }
}