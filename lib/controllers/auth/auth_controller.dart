import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phum_kasikor/view/Customer/customer_home_screen.dart';

import '../../core/network/api_client.dart';
import '../../core/network/api_exception.dart';
import '../../core/storage/token_storage.dart';
import '../../model/user_model.dart';
import '../../view/Farmer/farmer_home_screen.dart';

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
  final errorMessage = RxnString();

  // Set once /register succeeds - needed by verifyOtp() to identify
  // which account the code belongs to.
  String? _pendingUserId;

  final _firebaseAuth = FirebaseAuth.instance;
  late final Future<void> _googleInit;

  @override
  void onInit() {
    super.onInit();
    _googleInit = GoogleSignIn.instance.initialize(
      serverClientId:
          '392917185692-1olantat1oah94rnq10cjjt80vk4f3qm.apps.googleusercontent.com',
    );
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      await _googleInit;
      final googleUser = await GoogleSignIn.instance.authenticate();
      final idToken = googleUser.authentication.idToken;

      if (idToken == null) {
        isLoading.value = false;
        _showError('Failed to get Google ID token.');
        return;
      }

      final credential = GoogleAuthProvider.credential(idToken: idToken);
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      final firebaseIdToken = await userCredential.user?.getIdToken();

      if (firebaseIdToken == null) {
        isLoading.value = false;
        _showError('Failed to get Firebase ID token.');
        return;
      }

      final json = await ApiClient.post('auth/firebase/verify', {
        'id_token': firebaseIdToken,
      });
      await TokenStorage.saveToken(json['token'] as String);
      final user = UserModel.fromJson(json['user'] as Map<String, dynamic>);
      final isNew = json['is_new'] as bool? ?? false;

      isLoading.value = false;

      if (isNew) {
        Get.toNamed('/choose-role');
        return;
      }

      await TokenStorage.saveRole(user.role.name);
      _goHome(user.role);
    } on GoogleSignInException catch (e) {
      isLoading.value = false;
      if (e.code != GoogleSignInExceptionCode.canceled) {
        _showError('Google sign-in failed. Please try again.');
      }
    } on ApiException catch (e) {
      isLoading.value = false;
      _showError(e.message);
    } catch (e) {
      isLoading.value = false;
      _showError('Google sign-in failed: ${e.toString()}');
    }
  }

  String get phone => signUpPhoneController.text.trim().isNotEmpty
      ? signUpPhoneController.text.trim()
      : loginPhoneController.text.trim();
  String get otp => otpControllers.map((controller) => controller.text).join();

  bool _validPhone(String value) =>
      value.trim().replaceAll(RegExp(r'[^0-9]'), '').length >= 8;

  void _showError(String message) {
    errorMessage.value = message;
    Get.snackbar(
      'Check your details',
      message,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// Logs in directly against the real backend - no OTP needed, since
  /// /login issues a token immediately for an already-verified account.
  Future<void> beginLogin() async {
    if (!_validPhone(loginPhoneController.text) ||
        loginPasswordController.text.trim().length < 6) {
      _showError(
        'Enter a valid phone number and a password of at least 6 characters.',
      );
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      final json = await ApiClient.post('auth/login', {
        'identifier': loginPhoneController.text.trim(),
        'password': loginPasswordController.text,
      });

      await TokenStorage.saveToken(json['token'] as String);
      final user = UserModel.fromJson(json['user'] as Map<String, dynamic>);

      isLoading.value = false;

      await TokenStorage.saveRole(user.role.name);
      _goHome(user.role);
    } on ApiException catch (e) {
      isLoading.value = false;
      _showError(e.message);
    }
  }

  Future<void> beginSignUp() async {
    if (signUpNameController.text.trim().isEmpty ||
        !_validPhone(signUpPhoneController.text) ||
        signUpPasswordController.text.trim().length < 6) {
      _showError(
        'Complete your name, phone number, and a password of at least 6 characters.',
      );
      return;
    }
    if (!acceptedTerms.value) {
      _showError('Please accept the Terms of Service and Privacy Policy.');
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      final email = signUpEmailController.text.trim();
      final json = await ApiClient.post('auth/register', {
        'name': signUpNameController.text.trim(),
        'phone': signUpPhoneController.text.trim(),
        if (email.isNotEmpty) 'email': email,
        'password': signUpPasswordController.text,
      });

      await TokenStorage.saveToken(json['token'] as String);
      final user = UserModel.fromJson(json['user'] as Map<String, dynamic>);
      _pendingUserId = user.id;

      isLoading.value = false;
      Get.toNamed('/otp');
    } on ApiException catch (e) {
      isLoading.value = false;
      _showError(e.message);
    }
  }

  Future<void> verifyOtp() async {
    if (otp.length != 6) {
      _showError('Enter the complete 6-digit verification code.');
      return;
    }
    if (_pendingUserId == null) {
      _showError('Something went wrong - please sign up again.');
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      await ApiClient.post('auth/verify', {
        'user_id': _pendingUserId,
        'code': otp,
      });

      isLoading.value = false;
      Get.offNamed('/choose-role');
    } on ApiException catch (e) {
      isLoading.value = false;
      _showError(e.message);
    }
  }

  void resendOtp() {
    resendSeconds.value = 45;
    Get.snackbar('Code sent', 'A new verification code was sent to $phone.');
  }

  /// Submits the chosen role - called from ChooseRoleScreen's Continue button.
  Future<void> submitRole() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      await ApiClient.put('profile/choose-role', {
        'role': selectedRole.value.name,
      });
      await TokenStorage.saveRole(selectedRole.value.name);

      isLoading.value = false;
      Get.toNamed('/profile-setup');
    } on ApiException catch (e) {
      isLoading.value = false;
      _showError(e.message);
    }
  }

  Future<void> saveProfile() async {
    if (profileNameController.text.trim().isEmpty) {
      _showError('Your full name is required.');
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      final farmName = farmNameController.text.trim();
      final bio = bioController.text.trim();

      await ApiClient.put('profile/setup', {
        'name': profileNameController.text.trim(),
        if (bio.isNotEmpty) 'bio': bio,
        if (selectedRole.value == UserRole.farmer && farmName.isNotEmpty)
          'farm_name': farmName,
      });

      isLoading.value = false;
      Get.toNamed('/location');
    } on ApiException catch (e) {
      isLoading.value = false;
      _showError(e.message);
    }
  }

  Future<void> completeLocation() async {
    if (provinceController.text.trim().isEmpty) {
      _showError('Choose your province or city first.');
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      final district = districtController.text.trim();
      final commune = communeController.text.trim();

      final json = await ApiClient.put('profile/location', {
        'province': provinceController.text.trim(),
        if (district.isNotEmpty) 'district': district,
        if (commune.isNotEmpty) 'commune': commune,
      });

      final user = UserModel.fromJson(json as Map<String, dynamic>);

      isLoading.value = false;

      _goHome(user.role);
    } on ApiException catch (e) {
      isLoading.value = false;
      _showError(e.message);
    }
  }

  void _goHome(UserRole role) {
    Get.offAll(
      () => role == UserRole.farmer
          ? const FarmerHomeScreen()
          : const CustomerHomeScreen(),
    );
  }

  @override
  void onClose() {
    for (final controller in [
      loginPhoneController,
      loginPasswordController,
      signUpNameController,
      signUpPhoneController,
      signUpEmailController,
      signUpPasswordController,
      profileNameController,
      farmNameController,
      bioController,
      addressController,
      profilePhoneController,
      provinceController,
      districtController,
      communeController,
      ...otpControllers,
    ]) {
      controller.dispose();
    }
    super.onClose();
  }
}
