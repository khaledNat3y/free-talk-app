import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:free_talk_app/core/helpers/extensions.dart';
import 'package:free_talk_app/core/helpers/logger.dart';
import 'package:free_talk_app/core/helpers/spacing.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/app_colors.dart';
import '../../main_screen/logic/theme_cubit/theme_cubit.dart';
import '../logic/auth_cubit.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_text_button.dart';
import 'widgets/custom_text_form_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}
class _SignupScreenState extends State<SignupScreen> {
  late final TextEditingController usernameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final GlobalKey<FormState> formKey;
  bool isObscure = true;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        horizontalSpace(5),
                        CustomTextButton(
                          title: 'Sign in',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    verticalSpace(20),
                    CustomTextFormField(
                      controller: usernameController,
                      hintText: 'Username',
                      validators: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter username';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(15),
                    CustomTextFormField(
                      controller: passwordController,
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
                      ),
                      hintText: 'Password',
                      validators: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(15),
                    CustomTextFormField(
                      controller: confirmPasswordController,
                      obscureText: isObscure,
                      hintText: 'Confirm Password',
                      validators: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter password';
                        }
                        if (value != passwordController.text) {
                          return 'Password does not match';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(15),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: 'Email',
                      validators: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Email';
                        }
                        return null;
                      },
                    ),
                    verticalSpace(5),
                    CustomTextButton(
                      title: 'Forgot Password?',
                      onPressed: () {},
                    ),
                    verticalSpace(30),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if(state is AuthError) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Oops...',
                            desc: state.message,
                            btnOkOnPress: () {},
                          ).show();
                          Logger.error(state.message);
                        }

                        if(state is AuthSuccess) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            title: 'Success',
                            desc: state.message,
                            btnOkColor: AppColors.primary,
                            btnOkOnPress: () {
                              context.pushReplacementNamed(Routes.loginScreen);
                            },
                          ).show();
                        }
                      },
                      builder: (context, state) {
                        // Show loading indicator when loading
                        if (state is AuthLoading) {
                          return const Center(
                            child: CircularProgressIndicator(color: AppColors.primary),
                          );
                        }

                        // Show button when not loading
                        return CustomButton(
                          isDarkMode: context.read<ThemeCubit>().isDarkMode,
                          title: 'Sign up',
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthCubit>().register(
                                usernameController.text,
                                emailController.text,
                                passwordController.text,
                              );
                            }
                          },
                        );
                      },
                    ),
                    verticalSpace(20),
                    CustomButton(
                      title: 'Login with Google',
                      onTap: () {},
                      isDarkMode: context.read<ThemeCubit>().isDarkMode,
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
