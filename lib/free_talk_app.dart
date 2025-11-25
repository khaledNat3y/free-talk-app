import 'package:flutter/material.dart';

class FreeTalkApp extends StatelessWidget {
  const FreeTalkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Language App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: const Color(0xFF6C5CE7),
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xFF6C5CE7),
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
      ),
      themeMode: ThemeMode.dark,
      home: Scaffold(),
    );
  }
}
