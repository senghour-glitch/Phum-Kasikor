import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/user_model.dart';
import '../../repositories/auth/auth_repository.dart';
import '../../view/Customer/customer_home_screen.dart';
import '../../widgets/farmer/farmer_bottom_nav.dart';

class LoginController extends GetxController {
	final _authRepository = AuthRepository();

	final identifierController = TextEditingController();
	final passwordController = TextEditingController();
	final isLoading = false.obs;
	final errorMessage = RxnString();

	Future<void> login() async {
		final identifier = identifierController.text.trim();
		final password = passwordController.text;

		if (identifier.isEmpty || password.isEmpty) {
			errorMessage.value = 'Enter your phone number and password.';
			return;
		}

		isLoading.value = true;
		errorMessage.value = null;

		try {
			final response = await _authRepository.login(
				identifier: identifier,
				password: password,
			);

			if (!response.success || response.data == null) {
				errorMessage.value = response.message ?? 'Unable to log in.';
				return;
			}

			_openHome(response.data!);
		} catch (_) {
			errorMessage.value = 'Connection error. Please try again.';
		} finally {
			isLoading.value = false;
		}
	}

	void signInWithGoogle() => _socialLoginUnavailable('Google');

	void signInWithFacebook() => _socialLoginUnavailable('Facebook');

	void _socialLoginUnavailable(String provider) {
		errorMessage.value = '$provider sign-in is not configured yet.';
		Get.snackbar('Sign-in unavailable', errorMessage.value!);
	}

	void _openHome(UserModel user) {
		if (user.role == UserRole.farmer) {
			Get.offAll(() => const FarmerBottomNav());
		} else {
			Get.offAll(() => const CustomerHomeScreen());
		}
	}

	@override
	void onClose() {
		identifierController.dispose();
		passwordController.dispose();
		super.onClose();
	}
}
