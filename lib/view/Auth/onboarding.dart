import 'package:flutter/material.dart';
import '../../widgets/auth/auth_header.dart';
import 'welcome_screen.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      child: Column(
        children: [
          const Spacer(),
          const AuthIllustration(
            icon: Icons.eco_rounded,
            color: Color(0xFFFFF2C5),
          ),
          const SizedBox(height: 36),
          const AuthTitle(
            center: true,
            title: 'Fresh From the Farm',
            subtitle:
                'Connect with local farmers and discover fresh produce grown near you.',
          ),
          const SizedBox(height: 22),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.remove, color: kFarmGreen),
              Icon(Icons.remove, color: Color(0xFFCBD7CC)),
              Icon(Icons.remove, color: Color(0xFFCBD7CC)),
            ],
          ),
          const Spacer(),
          FarmButton(
            label: 'Next',
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const WelcomeScreen()),
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}
