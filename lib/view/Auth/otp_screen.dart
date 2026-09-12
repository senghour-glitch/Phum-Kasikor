import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../widgets/auth/auth_header.dart';
import '../../controllers/auth/verification_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerificationController());

    return AuthPage(
      showBack: true,
      child: Column(
        children: [
          const Spacer(),
          const AuthIllustration(
            icon: Icons.phonelink_lock_rounded,
            color: Color(0xFFC8F1F5),
          ),
          const SizedBox(height: 32),
          AuthTitle(
            center: true,
            title: 'OTP Verification',
            subtitle: 'Enter the 6-digit code sent to '
                '${controller.verification.phone ?? controller.verification.email ?? ''}',
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              6,
              (index) => SizedBox(
                width: 42,
                child: KeyboardListener(
                  focusNode: FocusNode(),
                  onKeyEvent: (event) {
                    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
                      controller.onBackspacePressed(index);
                    }
                  },
                  child: TextField(
                    controller: controller.digitControllers[index],
                    focusNode: controller.focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: const InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => controller.onDigitChanged(value, index),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => controller.errorMessage.value != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(controller.errorMessage.value!, style: const TextStyle(color: Colors.red, fontSize: 12)),
                )
              : const SizedBox.shrink()),
          Obx(() => controller.secondsRemaining.value > 0
              ? Text(
                  'Resend code in 00:${controller.secondsRemaining.value.toString().padLeft(2, '0')}',
                  style: const TextStyle(color: kFarmMuted, fontSize: 12),
                )
              : TextButton(onPressed: controller.resend, child: const Text('Resend code'))),
          const SizedBox(height: 20),
          Obx(() => FarmButton(
            label: controller.isVerifying.value ? 'Verifying...' : 'Verify',
            onPressed: controller.isVerifying.value ? null : controller.verify,
          )),
          const Spacer(),
        ],
      ),
    );
  }
}