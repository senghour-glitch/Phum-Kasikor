import 'package:flutter/material.dart';
import '../../widgets/auth/auth_header.dart';
import 'onboarding.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kFarmGreen,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.agriculture_rounded,
                color: kFarmGreen,
                size: 36,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'ភូមិកសិករ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Text(
              'PHUM KASIKOR',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 9,
                letterSpacing: 1.8,
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
            const SizedBox(height: 18),
            TextButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const Onboarding()),
              ),
              child: const Text(
                'Tap to continue',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
