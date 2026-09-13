import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/widgets/auth/auth_header.dart';
import 'package:phum_kasikor/controllers/auth/login_controller.dart';
import 'sigup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

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
            FarmTextField(
              label: 'Phone number',
              hint: '+855 12 345 678',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              controller: controller.identifierController,
            ),
            FarmTextField(
              label: 'Password',
              hint: '••••••••',
              prefixIcon: Icons.lock_outline,
              obscureText: true,
              controller: controller.passwordController,
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
            Obx(() => controller.errorMessage.value != null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(controller.errorMessage.value!, style: const TextStyle(color: Colors.red, fontSize: 12)),
                  )
                : const SizedBox.shrink()),
            const SizedBox(height: 12),
            Obx(() => FarmButton(
              label: controller.isLoading.value ? 'Logging in...' : 'Log in',
              onPressed: controller.isLoading.value ? null : controller.login,
            )),
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
            Obx(() => Row(
              children: [
                Expanded(
                  child: FarmButton(
                    label: 'Google',
                    outlined: true,
                    onPressed: controller.isLoading.value ? null : controller.signInWithGoogle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FarmButton(
                    label: 'Facebook',
                    outlined: true,
                    onPressed: controller.isLoading.value ? null : controller.signInWithFacebook,
                  ),
                ),
              ],
            )),
            const SizedBox(height: 18),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SigupScreen()),
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