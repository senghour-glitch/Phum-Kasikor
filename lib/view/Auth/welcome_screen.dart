import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/auth/auth_header.dart';
import 'login_screen.dart';
import 'sigup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      child: Column(
        children: [
          const Spacer(),
          const AuthIllustration(
            icon: Icons.handshake_rounded,
            color: Color(0xFFFFF5D7),
          ),
          const SizedBox(height: 24),
          const AuthBrand(compact: true),
          const SizedBox(height: 14),
          const AuthTitle(
            center: true,
            title: 'Welcome to Phum Kasikor',
            subtitle: 'The local marketplace for farmers and customers.',
          ),
          const Spacer(),
          FarmButton(
            label: 'Log in',
            onPressed: () => Get.toNamed('/login'),
          ),
          const SizedBox(height: 10),
          FarmButton(
            label: 'Create an account',
            outlined: true,
<<<<<<< HEAD
            onPressed: () => Get.toNamed('/sign-up'),
=======
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SigupScreen()),
            ),
>>>>>>> 4378a247e554c8536c582b7bc00fcb67f387ba60
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}
