import 'package:flutter/material.dart';
import '../../widgets/auth/auth_header.dart';
import 'otp_screen.dart';

class SinUpScreen extends StatelessWidget {
  const SinUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      showBack: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18),
            const AuthTitle(
              title: 'Create Account',
              subtitle: 'Join Phum Kasikor and support local farmers.',
            ),
            const SizedBox(height: 25),
            const FarmTextField(
              label: 'Full name',
              hint: 'Sok Dara',
              prefixIcon: Icons.person_outline,
            ),
            const FarmTextField(
              label: 'Phone number',
              hint: '+855 12 345 678',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const FarmTextField(
              label: 'Email (optional)',
              hint: 'you@example.com',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const FarmTextField(
              label: 'Password',
              hint: 'Create a password',
              prefixIcon: Icons.lock_outline,
              obscureText: true,
            ),
            Row(
              children: [
                Checkbox(
                  value: true,
                  activeColor: kFarmGreen,
                  onChanged: (_) {},
                ),
                const Expanded(
                  child: Text(
                    'I agree to the Terms of Service and Privacy Policy',
                    style: TextStyle(fontSize: 11, color: kFarmMuted),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            FarmButton(
              label: 'Create Account',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OtpScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
