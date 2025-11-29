import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:free_talk_app/core/helpers/extensions.dart';
import 'package:free_talk_app/core/helpers/shared_pref_helper.dart';
import 'package:free_talk_app/core/helpers/spacing.dart';
import 'package:free_talk_app/core/routing/routes.dart';
import 'package:free_talk_app/core/theming/app_colors.dart';
import 'package:free_talk_app/features/auth/logic/auth_cubit.dart';
import 'package:free_talk_app/features/auth/ui/widgets/custom_button.dart';
import 'package:free_talk_app/features/auth/ui/widgets/custom_text_button.dart';
import 'package:free_talk_app/features/auth/ui/widgets/custom_text_form_field.dart';
import 'package:free_talk_app/features/main_screen/logic/theme_cubit/theme_cubit.dart';

import '../../../core/helpers/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool isObscure = true;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SvgPicture.asset('assets/images/Ellipse.svg'),
            SvgPicture.asset('assets/images/Rectangle 6.svg'),
            SvgPicture.asset('assets/images/Rectangle 10.svg'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(70),
                    Text(
                      'Login',
                      style: TextStyle(
                        color: context.read<ThemeCubit>().isDarkMode
                            ? AppColors.white
                            : AppColors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpace(10),
                    Row(
                      children: [
                        Text(
                          'don’t have an account?',
                          style: TextStyle(
                            color: context.read<ThemeCubit>().isDarkMode
                                ? AppColors.white
                                : AppColors.black,
                            fontSize: 16,
                          ),
                        ),
                        verticalSpace(5),
                        CustomTextButton(
                          title: 'Sign up',
                          onPressed: () =>
                              context.pushNamed(Routes.signupScreen),
                        ),
                      ],
                    ),
                    verticalSpace(30),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: 'Email',
                      validators: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter username';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(40),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: isObscure,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: Icon(
                          isObscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        color: AppColors.black,
                      ),
                      validators: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(10),
                    CustomTextButton(
                      title: 'Forgot Password?',
                      onPressed: () {},
                    ),
                    verticalSpace(50),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) async {
                        if (state is AuthError) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Oops...',
                            desc: state.message,
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          ).show();
                        }

                        if (state is AuthSuccess) {
                          context.pushNamed(Routes.mainScreen);
                          AwesomeDialog(
                            context: context,
                            animType: AnimType.rightSlide,
                            dialogType: DialogType.success,
                            title: 'Success',
                            desc: state.message,
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {},
                          ).show();
                        }
                      },
                      builder: (context, state) {
                        // Show loading indicator when loading
                        if (state is AuthLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          );
                        }
                        return CustomButton(
                          isDarkMode: context.read<ThemeCubit>().isDarkMode,
                          title: 'Login',
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthCubit>().login(
                                emailController.text,
                                passwordController.text,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
