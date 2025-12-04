import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:free_talk_app/core/helpers/extensions.dart';
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
              child: SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: IntrinsicHeight(
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
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
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
                                  return 'Enter username';
                                }
                                if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$")
                                    .hasMatch(value)) {
                                  return 'Enter valid email';
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
                                // Handle navigation after build is complete
                                if (state is AuthSuccess) {
                                  context.pushReplacementNamed(Routes.loginScreen);
                                }
                              },
                              builder: (context, state) {
                                // Show loading indicator when loading
                                if (state is AuthLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(color: AppColors.primary),
                                  );
                                }

                                if (state is AuthError) {
                                  return Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          state.message,
                                          style: const TextStyle(color: Colors.red),
                                        ),
                                      ),
                                      verticalSpace(10),
                                      CustomButton(
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
                                      ),
                                    ],
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}