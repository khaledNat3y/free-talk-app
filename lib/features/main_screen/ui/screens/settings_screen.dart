import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_talk_app/core/helpers/logger.dart';
import 'package:free_talk_app/core/theming/app_colors.dart';
import 'package:free_talk_app/features/main_screen/ui/widgets/settingsItem.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../logic/theme_cubit/theme_cubit.dart';
import 'supported_languages_screen.dart';

class SettingsScreen extends StatefulWidget {
  final GlobalKey<NavigatorState>? navigatorKey;

  const SettingsScreen({super.key, this.navigatorKey});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String userName = '';
  String userEmail = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final String fetchedUserName = await SharedPrefHelper.getString(
        "userName",
      );
      final String fetchedUserEmail = await SharedPrefHelper.getString(
        "userEmail",
      );

      setState(() {
        userName = fetchedUserName;
        userEmail = fetchedUserEmail;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Logger.debug('Error fetching user data: $e');
    }
  }

  void _handleLogout() {
    AwesomeDialog(
      context: context,
      animType: AnimType.rightSlide,
      dialogType: DialogType.warning,
      title: 'Logout',
      desc: 'Are you sure you want to logout?',
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        await context.read<AuthCubit>().signOut();
        if (mounted) {
          Navigator.of(context, rootNavigator: true)
              .pushNamedAndRemoveUntil(
            Routes.loginScreen,
                (route) => false,
          );
        }
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                verticalSpace(20),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 12,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade600,
                          ),
                          child: Center(
                            child: isLoading
                                ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                                : Text(
                              userName.isNotEmpty
                                  ? userName[0].toUpperCase()
                                  : 'U',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: isLoading
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? Colors.white24
                                      : Colors.black12,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                width: 150,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? Colors.white24
                                      : Colors.black12,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          )
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                userEmail,
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white60
                                      : Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: isDarkMode ? Colors.white60 : Colors.black54,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDarkMode
                              ? Colors.white.withValues(alpha: 0.1)
                              : Colors.black,
                        ),
                        child: const Icon(
                          Icons.dark_mode,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Dark Mode',
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Transform.scale(
                        scale: 0.85,
                        child: Switch(
                          value: isDarkMode,
                          onChanged: (value) {
                            context.read<ThemeCubit>().setTheme(value);
                          },
                          activeColor: isDarkMode
                              ? Colors.black
                              : AppColors.white,
                          activeTrackColor: isDarkMode
                              ? AppColors.white
                              : AppColors.black,
                          inactiveThumbColor: AppColors.white,
                          inactiveTrackColor: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 12),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ),
                SettingItem(
                  icon: Icons.person_outline,
                  iconColor: Colors.orange,
                  title: 'Edit Profile',
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(height: 12),
                SettingItem(
                  icon: Icons.lock_outline,
                  iconColor: Colors.blue,
                  title: 'Change Password',
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 12),
                  child: Text(
                    'Regional',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ),
                SettingItem(
                  icon: Icons.language,
                  iconColor: const Color(0xFF6C5CE7),
                  title: 'Language',
                  isDarkMode: isDarkMode,
                  onTap: () {
                    if (widget.navigatorKey != null) {
                      widget.navigatorKey!.currentState?.push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SupportedLanguagesScreen(isDarkMode: isDarkMode),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 12),
                SettingItem(
                  icon: Icons.logout,
                  iconColor: Colors.orange,
                  title: 'Logout',
                  isDarkMode: isDarkMode,
                  onTap: _handleLogout,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}