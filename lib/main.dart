import 'package:final_exam/screens/home_screen.dart';
import 'package:final_exam/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Scaffolding App',
      // Apply the theme here
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Automatically switch between light/dark
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}