import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/auth/auth_header.dart';
import '../../controllers/auth/signup_controller.dart';

class SigupScreen extends StatelessWidget {
  const SigupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return AuthPage(
      showBack: true,

      child: Form(
        key: controller.formKey,

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

              FarmTextField(
                label: 'Full name',
                hint: 'Sok Dara',
                prefixIcon: Icons.person_outline,
                controller: controller.nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your full name.';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters.';
                  }
                  return null;
                },
              ),

              FarmTextField(
                label: 'Phone number',
                hint: '+855 12 345 678',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                controller: controller.phoneController,
                validator: (value) {
                  final phone = value?.trim() ?? '';

                  if (phone.isEmpty && controller.emailController.text.trim().isEmpty) {
                    return 'Enter a phone number or email.';
                  }
                  if (phone.isEmpty) return null;

                  final cleanedPhone = phone.replaceAll(RegExp(r'[\s-]'), '');
                  final phoneRegex = RegExp(r'^(\+855|0)(1[0-9]|6[0-9]|7[0-9]|8[0-9]|9[0-9])\d{6,7}$');

                  if (!phoneRegex.hasMatch(cleanedPhone)) {
                    return 'Please enter a valid Cambodian phone number.';
                  }
                  return null;
                },
              ),

              FarmTextField(
                label: 'Email (optional)',
                hint: 'you@example.com',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                controller: controller.emailController,
                validator: (value) {
                  final email = value?.trim() ?? '';

                  if (email.isEmpty && controller.phoneController.text.trim().isEmpty) {
                    return 'Enter an email or phone number.';
                  }
                  if (email.isEmpty) return null;

                  final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                  if (!emailRegex.hasMatch(email)) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
              ),

              FarmTextField(
                label: 'Password',
                hint: 'Create a password',
                prefixIcon: Icons.lock_outline,
                obscureText: true,
                controller: controller.passwordController,
                validator: (value) {
                  final password = value ?? '';
                  if (password.isEmpty) return 'Please create a password.';
                  if (password.length < 8) return 'Password must be at least 8 characters.';
                  return null;
                },
              ),

              Obx(() => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: controller.agreeToTerms.value,
                    activeColor: kFarmGreen,
                    onChanged: controller.toggleAgreeToTerms,
                  ),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Text(
                        'I agree to the Terms of Service and Privacy Policy',
                        style: TextStyle(fontSize: 11, color: kFarmMuted),
                      ),
                    ),
                  ),
                ],
              )),

              const SizedBox(height: 12),

              Obx(() => FarmButton(
                
                label: controller.isSubmitting.value ? 'Creating account...' : 'Create Account',
                onPressed: controller.isSubmitting.value ? null : controller.createAccount,
              )),
            ],
          ),
        ),
      ),
    );
  }
}