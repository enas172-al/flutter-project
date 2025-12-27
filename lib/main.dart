import 'package:flutter/material.dart';
import 'core/constants/app_color.dart';
import 'features/welcome/view/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: 'Cairo',
        primaryColor: AppColors.primary,
      ),

      home: const WelcomeScreen(), // 👈 البداية
    );
  }
}
