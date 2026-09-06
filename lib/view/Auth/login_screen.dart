import 'package:flutter/material.dart';
import '../../widgets/auth/auth_header.dart';
import 'otp_screen.dart';
import 'sin_up_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      showBack: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 28),
            const AuthBrand(compact: true),
            const SizedBox(height: 28),
            const AuthTitle(
              title: 'Welcome Back!',
              subtitle: 'Log in to continue shopping local.',
            ),
            const SizedBox(height: 28),
            const FarmTextField(
              label: 'Phone number',
              hint: '+855 12 345 678',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const FarmTextField(
              label: 'Password',
              hint: '••••••••',
              prefixIcon: Icons.lock_outline,
              obscureText: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: kFarmGreen),
                ),
              ),
            ),
            const SizedBox(height: 12),
            FarmButton(
              label: 'Log in',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OtpScreen()),
              ),
            ),
            const SizedBox(height: 22),
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'or continue with',
                    style: TextStyle(fontSize: 12, color: kFarmMuted),
                  ),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: FarmButton(
                    label: 'Google',
                    outlined: true,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FarmButton(
                    label: 'Facebook',
                    outlined: true,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SinUpScreen()),
                ),
                child: const Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(color: kFarmGreen),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
