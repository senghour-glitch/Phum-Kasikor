import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:phum_kasikor/core/routes/app_routes.dart';
import 'package:phum_kasikor/core/storage/token_storage.dart';
import 'package:phum_kasikor/repositories/auth/auth_repository.dart';
import 'package:phum_kasikor/view/Auth/choose_role_screen.dart';

class LoginController extends GetxController {
  final _authRepository = AuthRepository();
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn.instance;

  final identifierController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final errorMessage = RxnString();

  Future<void> login() async {
    final identifier = identifierController.text.trim();
    final password = passwordController.text;

    if (identifier.isEmpty || password.isEmpty) {
      errorMessage.value = 'Please enter your phone/email and password.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    final response = await _authRepository.login(identifier: identifier, password: password);

    isLoading.value = false;

    if (!response.success) {
      errorMessage.value = response.message;
      return;
    }

    final user = response.data!;

    if (!user.hasRole) {
      // Shouldn't normally happen for a password login, but handle it
      // defensively in case an account never finished onboarding.
      Get.to(() => const ChooseRoleScreen());
      return;
    }

    await TokenStorage.saveRole(user.role!);
    _goHome(user.role!);
  }

  @override
  void onClose() {
    identifierController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      await _googleSignIn.initialize(
        serverClientId: '392917185692-9f1cf587ba22aea2e16959.apps.googleusercontent.com',
      );
      final googleUser = await _googleSignIn.authenticate();
      if (googleUser == null) {
        // User cancelled the picker.
        isLoading.value = false;
        return;
      }

      final googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      final idToken = await userCredential.user!.getIdToken();

      await _handleFirebaseLogin(idToken!);
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Google sign-in failed. Please try again.';
    }
  }

  Future<void> signInWithFacebook() async {
    isLoading.value = true;
    errorMessage.value = null;

    try {
      final result = await FacebookAuth.instance.login();

      if (result.status != LoginStatus.success) {
        // User cancelled, or it failed - either way, nothing to do.
        isLoading.value = false;
        if (result.status == LoginStatus.failed) {
          errorMessage.value = 'Facebook sign-in failed. Please try again.';
        }
        return;
      }

      final accessToken = result.accessToken!.tokenString;
      final credential = FacebookAuthProvider.credential(accessToken);

      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      final idToken = await userCredential.user!.getIdToken();

      await _handleFirebaseLogin(idToken!);
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Facebook sign-in failed. Please try again.';
    }
  }

  Future<void> _handleFirebaseLogin(String idToken) async {
    final response = await _authRepository.firebaseLogin(idToken: idToken);

    isLoading.value = false;

    if (!response.success) {
      errorMessage.value = response.message;
      return;
    }

    final isNew = response.data!['isNew'] as bool;

    if (isNew) {
      Get.to(() => const ChooseRoleScreen());
      return;
    }

    final user = response.data!['user'];
    if (user.hasRole) {
      await TokenStorage.saveRole(user.role);
      _goHome(user.role);
    } else {
      Get.to(() => const ChooseRoleScreen());
    }
  }

  void _goHome(String role) {
    if (role == 'farmer') {
      Get.offAllNamed(AppRoutes.farmerHome);
    } else {
      Get.offAllNamed(AppRoutes.customerHome);
    }
  }
}