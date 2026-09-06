import 'package:flutter/material.dart';
import '../../widgets/auth/auth_header.dart';
import 'choose_role_screen.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      showBack: true,
      child: Column(
        children: [
          const Spacer(),
          const AuthIllustration(
            icon: Icons.phonelink_lock_rounded,
            color: Color(0xFFC8F1F5),
          ),
          const SizedBox(height: 32),
          const AuthTitle(
            center: true,
            title: 'OTP Verification',
            subtitle: 'Enter the 6-digit code sent to +855 12 345 678',
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              6,
              (index) => SizedBox(
                width: 42,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  decoration: const InputDecoration(
                    counterText: '',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Resend code in 00:45',
            style: TextStyle(color: kFarmMuted, fontSize: 12),
          ),
          const SizedBox(height: 20),
          FarmButton(
            label: 'Verify',
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ChooseRoleScreen()),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
