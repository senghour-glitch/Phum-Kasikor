import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../model/user_model.dart';
import '../../repositories/auth/auth_repository.dart';

class ProfileController extends GetxController {
  final _authRepository = AuthRepository();

  final isLoading = false.obs;
  final isLoggingOut = false.obs;
  final errorMessage = RxnString();
  final profile = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;
    errorMessage.value = null;

    final response = await _authRepository.me();

    isLoading.value = false;
    if (response.success && response.data != null) {
      profile.value = response.data;
      return;
    }

    errorMessage.value = response.message ?? 'Unable to load your profile.';
  }

  Future<void> refreshProfile() => loadProfile();

  Future<void> logout() async {
    if (isLoggingOut.value) return;

    isLoggingOut.value = true;
    try {
      await _authRepository.logout();
      Get.offAllNamed(AppRoutes.login);
    } catch (error) {
      errorMessage.value = error.toString();
      Get.snackbar(
        'Logout failed',
        'Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoggingOut.value = false;
    }
  }
}
