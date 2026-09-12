import 'package:get/get.dart';
import '../../repositories/auth/auth_repository.dart';
import '../../view/Auth/profile_setup_screen.dart';

class RoleSelectionController extends GetxController {
  final _authRepository = AuthRepository();

  final selectedRole = RxnString();
  final isLoading = false.obs;
  final errorMessage = RxnString();

  void selectRole(String role) => selectedRole.value = role;

  Future<void> confirmRole() async {
    if (selectedRole.value == null) {
      errorMessage.value = 'Please choose a role to continue.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    final response = await _authRepository.chooseRole(role: selectedRole.value!);

    isLoading.value = false;

    if (!response.success) {
      errorMessage.value = response.message;
      return;
    }

    Get.to(() => const ProfileSetupScreen());
  }
}