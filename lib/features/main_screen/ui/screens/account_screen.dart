import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/spacing.dart';
import '../../logic/theme_cubit/theme_cubit.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, bool>(
      builder: (context, isDarkMode) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Account',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                verticalSpace(20),
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Account',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

// Account Details Card
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C5CE7),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'hishanesam916@gmail.com',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Name',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Hisham Esam',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Password',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Show Password',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        '••••••••••••',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

// Help Section
                Text(
                  'Help',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C5CE7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.help_outline, color: Colors.white),
                    title: const Text(
                      'Frequently asked questions',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C5CE7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.comment, color: Colors.white),
                    title: const Text(
                      'Make comment',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}














