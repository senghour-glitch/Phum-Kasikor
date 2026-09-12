import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/auth_model.dart';
import '../model/user_model.dart';
import '../view/Custommer/customer_home_screen.dart';
import '../view/Farmer/farmer_home_screen.dart';

class AuthController extends GetxController {
  final loginPhoneController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final signUpNameController = TextEditingController();
  final signUpPhoneController = TextEditingController();
  final signUpEmailController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final profileNameController = TextEditingController();
  final farmNameController = TextEditingController();
  final bioController = TextEditingController();
  final addressController = TextEditingController();
  final profilePhoneController = TextEditingController();
  final provinceController = TextEditingController(text: 'Phnom Penh');
  final districtController = TextEditingController();
  final communeController = TextEditingController();
  final otpControllers = List.generate(6, (_) => TextEditingController());

  final selectedRole = UserRole.farmer.obs;
  final acceptedTerms = false.obs;
  final isLoading = false.obs;
  final resendSeconds = 45.obs;
  final _isSignUpFlow = false.obs;

  String get phone => _isSignUpFlow.value
      ? signUpPhoneController.text.trim()
      : loginPhoneController.text.trim();
  String get otp => otpControllers.map((controller) => controller.text).join();

  void beginLogin() {
    if (!_validPhone(loginPhoneController.text) ||
        loginPasswordController.text.trim().length < 6) {
      _showError('Enter a valid phone number and a password of at least 6 characters.');
      return;
    }
    _isSignUpFlow.value = false;
    Get.toNamed('/otp');
  }

  void beginSignUp() {
    if (signUpNameController.text.trim().isEmpty ||
        !_validPhone(signUpPhoneController.text) ||
        signUpPasswordController.text.trim().length < 6) {
      _showError('Complete your name, phone number, and a password of at least 6 characters.');
      return;
    }
    if (!acceptedTerms.value) {
      _showError('Please accept the Terms of Service and Privacy Policy.');
      return;
    }
    _isSignUpFlow.value = true;
    Get.toNamed('/otp');
  }

  void verifyOtp() {
    if (otp.length != 6) {
      _showError('Enter the complete 6-digit verification code.');
      return;
    }
    Get.offNamed('/choose-role');
  }

  void resendOtp() {
    resendSeconds.value = 45;
    Get.snackbar('Code sent', 'A new verification code was sent to $phone.');
  }

  void saveProfile() {
    if (profileNameController.text.trim().isEmpty ||
        profilePhoneController.text.trim().isEmpty) {
      _showError('Your full name and phone number are required.');
      return;
    }
    Get.toNamed('/location');
  }

  Future<void> completeLocation() async {
    if (provinceController.text.trim().isEmpty) {
      _showError('Choose your province or city first.');
      return;
    }
    isLoading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 350));
    isLoading.value = false;

    final session = AuthSession(
      accessToken: 'demo-access-token',
      expiresAt: DateTime.now().add(const Duration(days: 1)),
      user: UserModel(
        id: 'demo-user',
        name: profileNameController.text.trim(),
        phone: profilePhoneController.text.trim(),
        email: signUpEmailController.text.trim().isEmpty
            ? null
            : signUpEmailController.text.trim(),
        role: selectedRole.value,
      ),
    );
    Get.put<AuthSession>(session, permanent: true);
    Get.offAll(() => selectedRole.value == UserRole.farmer
        ? const FarmerHomeScreen()
        : const CustomerHomeScreen());
  }

  bool _validPhone(String value) => value.trim().replaceAll(RegExp(r'[^0-9]'), '').length >= 8;

  void _showError(String message) => Get.snackbar(
    'Check your details',
    message,
    snackPosition: SnackPosition.BOTTOM,
  );

  @override
  void onClose() {
    for (final controller in [
      loginPhoneController, loginPasswordController, signUpNameController,
      signUpPhoneController, signUpEmailController, signUpPasswordController,
      profileNameController, farmNameController, bioController,
      addressController, profilePhoneController, provinceController,
      districtController, communeController, ...otpControllers,
    ]) {
      controller.dispose();
    }
    super.onClose();
  }
}
