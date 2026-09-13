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

  late final GoogleSignIn _googleSignIn;

  @override
  void onInit() {
    super.onInit();
    // Initialize Google Sign-In with serverClientId for backend communication
    _googleSignIn = GoogleSignIn(
      serverClientId:
          '392917185692-1olantat1oah94rnq10cjjt80vk4f3qm.apps.googleusercontent.com',
      scopes: ['email', 'profile'],
    );
  }

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

    final response = await _authRepository.login(
      identifier: identifier,
      password: password,
    );

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
      // Sign out first to ensure fresh login
      await _googleSignIn.signOut();

      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User cancelled the picker.
        isLoading.value = false;
        return;
      }

      final googleAuth = await googleUser.authentication;

      // Ensure we have both tokens
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        isLoading.value = false;
        errorMessage.value = 'Failed to get authentication tokens from Google.';
        return;
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken!,
        idToken: googleAuth.idToken!,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      // Get fresh ID token from Firebase
      final idToken = await userCredential.user?.getIdToken();

      if (idToken == null) {
        isLoading.value = false;
        errorMessage.value = 'Failed to get Firebase ID token.';
        return;
      }

      await _handleFirebaseLogin(idToken);
    } catch (e) {
      isLoading.value = false;
      print('Google Sign-In Error: $e');
      errorMessage.value = 'Google sign-in failed: ${e.toString()}';
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

      final accessToken = result.accessToken?.tokenString;

      if (accessToken == null) {
        isLoading.value = false;
        errorMessage.value = 'Failed to get Facebook access token.';
        return;
      }

      final credential = FacebookAuthProvider.credential(accessToken);

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      // Get fresh ID token from Firebase
      final idToken = await userCredential.user?.getIdToken();

      if (idToken == null) {
        isLoading.value = false;
        errorMessage.value = 'Failed to get Firebase ID token.';
        return;
      }

      await _handleFirebaseLogin(idToken);
    } catch (e) {
      isLoading.value = false;
      print('Facebook Sign-In Error: $e');
      errorMessage.value = 'Facebook sign-in failed: ${e.toString()}';
    }
  }

  Future<void> _handleFirebaseLogin(String idToken) async {
    try {
      final response = await _authRepository.firebaseLogin(idToken: idToken);

      isLoading.value = false;

      if (!response.success) {
        errorMessage.value =
            response.message ?? 'Authentication failed. Please try again.';
        return;
      }

      final data = response.data;
      if (data == null) {
        errorMessage.value = 'No response data from server.';
        return;
      }

      final isNew = data['isNew'] as bool? ?? false;

      if (isNew) {
        Get.to(() => const ChooseRoleScreen());
        return;
      }

      final user = data['user'];
      if (user == null) {
        errorMessage.value = 'Failed to load user data.';
        return;
      }

      if (user.hasRole) {
        await TokenStorage.saveRole(user.role);
        _goHome(user.role);
      } else {
        Get.to(() => const ChooseRoleScreen());
      }
    } catch (e) {
      isLoading.value = false;
      print('Firebase Login Error: $e');
      errorMessage.value = 'Login failed: ${e.toString()}';
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
