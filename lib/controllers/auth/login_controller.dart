import 'package:get/get.dart';
import 'package:phum_kasikor/view/Customer/customer_home_screen.dart';
import '../../core/storage/token_storage.dart';
import '../../repositories/auth/auth_repository.dart';
import '../../view/farmer/farmer_home_screen.dart';

class LocationSetupController extends GetxController {
  final _authRepository = AuthRepository();

  final isLoading = false.obs;
  final errorMessage = RxnString();

  Future<void> save({
    required String province,
    String? district,
    String? commune,
    double? latitude,
    double? longitude,
  }) async {
    isLoading.value = true;
    errorMessage.value = null;

    final response = await _authRepository.setupLocation(
      province: province,
      district: district,
      commune: commune,
      latitude: latitude,
      longitude: longitude,
    );

    isLoading.value = false;

    if (!response.success) {
      errorMessage.value = response.message;
      return;
    }

    await _goHome();
  }

  Future<void> skip() async => _goHome();

  Future<void> _goHome() async {
    final role = await TokenStorage.getRole();

    if (role == 'farmer') {
      Get.offAll(() => const FarmerHomeScreen());
    } else {
      Get.offAll(() => const CustomerHomeScreen());
    }
  }
}