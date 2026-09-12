import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/verification_model.dart';
import '../../repositories/auth/auth_repository.dart';
import '../../view/Auth/choose_role_screen.dart';

class VerificationController extends GetxController {
  final _authRepository = AuthRepository();

  late VerificationModel verification;

  // One controller per OTP digit box, matching your 6-box UI.
  final digitControllers = List.generate(6, (_) => TextEditingController());
  final focusNodes = List.generate(6, (_) => FocusNode());

  final isVerifying = false.obs;
  final errorMessage = RxnString();
  final secondsRemaining = 60.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is VerificationModel) {
      verification = Get.arguments as VerificationModel;
    } else {
      verification = VerificationModel(userId: 0, phone: '', email: ''); 
    }
    _startResendTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (final c in digitControllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.onClose();
  }

  void _startResendTimer() {
    secondsRemaining.value = 45;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value == 0) {
        timer.cancel();
      } else {
        secondsRemaining.value--;
      }
    });
  }

  void onDigitChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    }

    // Auto-submit once all 6 boxes are filled.
    if (digitControllers.every((c) => c.text.isNotEmpty)) {
      verify();
    }
  }

  /// Called on every key press in a digit box - handles Backspace
  /// explicitly, since onChanged alone doesn't reliably fire when
  /// deleting from a box that's already empty.
  void onBackspacePressed(int index) {
    if (digitControllers[index].text.isEmpty && index > 0) {
      digitControllers[index - 1].clear();
      focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> verify() async {
    final code = digitControllers.map((c) => c.text).join();

    if (code.length < 6) {
      errorMessage.value = 'Please enter the full 6-digit code.';
      return;
    }

    isVerifying.value = true;
    errorMessage.value = null;

    final response = await _authRepository.verify(userId: verification.userId, code: code);

    isVerifying.value = false;

    if (!response.success) {
      errorMessage.value = response.message;
      Get.snackbar('Verification failed', response.message ?? 'Please try again.');
      return;
    }

    Get.offAll(() => const ChooseRoleScreen());
  }

  void resend() {
    // TODO: wire to a resend-code endpoint once one exists on the backend.
    _startResendTimer();
    Get.snackbar('Code sent', 'A new code has been sent (once resend is wired up backend-side).');
  }
}