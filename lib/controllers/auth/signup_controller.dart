import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/verification_model.dart';
import '../../repositories/auth/auth_repository.dart';
import '../../view/Auth/otp_screen.dart';

class SignupController extends GetxController {
  final _authRepository = AuthRepository();

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final agreeToTerms = false.obs;
  final isSubmitting = false.obs;
  final errorMessage = RxnString();

  void toggleAgreeToTerms(bool? value) => agreeToTerms.value = value ?? false;

  Future<void> createAccount() async {
    if (!formKey.currentState!.validate()) return;

    if (!agreeToTerms.value) {
      Get.snackbar(
        'Almost there',
        'Please agree to the Terms of Service and Privacy Policy.',
        snackPosition: SnackPosition.BOTTOM, 
        backgroundColor: Colors.red.shade50, 
        colorText: Colors.red.shade900, 
        icon: Icon(
          Icons.error_outline_rounded,
          color: Colors.red.shade700,
          size: 28,
        ),
        margin: const EdgeInsets.all(16), 
        borderRadius: 16, 
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        duration: const Duration(seconds: 3), 
        leftBarIndicatorColor: Colors.red.shade700, 
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack, 
      );
      return;
    }

    isSubmitting.value = true;
    errorMessage.value = null;

    final phone = phoneController.text.trim();
    final email = emailController.text.trim();

    try {
      final response = await _authRepository.register(
        name: nameController.text.trim(),
        phone: phone.isEmpty ? null : phone,
        email: email.isEmpty ? null : email,
        password: passwordController.text,
      );

      if (!response.success) {
        errorMessage.value = response.message;
        Get.snackbar('Sign up failed', response.message ?? 'Please try again.');
        return;
      }

      final userId = (response.data!['user']).id as int;

      Get.to(() => const OtpScreen(), arguments: VerificationModel(
        userId: userId,
        phone: phone.isEmpty ? null : phone,
        email: email.isEmpty ? null : email,
      ));

    } catch (e) {
      // Catches server crashes, timeout errors, or API issues
      errorMessage.value = 'Connection error. Please try again.';
      Get.snackbar(
        'Error Occurred',
        e.toString(), // Displays the exact error reason on the screen
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade50,
        colorText: Colors.red.shade900,
        duration: const Duration(seconds: 5),
      );
      print("API Error: $e");
    } finally {
      // ALWAYS runs at the end, guaranteeing the button unfreezes
      isSubmitting.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}