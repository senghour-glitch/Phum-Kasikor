import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/color/color.dart';
import 'package:phum_kasikor/view/Auth/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(() => const OnboardingScreen(),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 900));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E7D32),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 10),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/logo.jpg',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 100,
                            color: AppColors.surface,
                            child: const Icon(
                              Icons.eco,
                              color: AppColors.primary,
                              size: 50,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'PHUM KASIKOR',
                      style: TextStyle(
                        color: AppColors.textOnPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Farm Fresh, Direct to You',
                      style: TextStyle(
                        color: AppColors.textOnPrimary.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom App Version Label
              Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: AppColors.textOnPrimary.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
