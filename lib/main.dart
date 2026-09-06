import 'package:flutter/material.dart';
import 'package:phum_kasikor/color/color.dart';
import 'package:phum_kasikor/view/Auth/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}
