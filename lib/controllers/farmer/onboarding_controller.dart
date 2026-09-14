import 'package:get/get.dart';

import '../../model/farmer_model.dart';
import '../../model/farm_model.dart';
import '../../model/user_model.dart';

class OnboardingController extends GetxController {
  final currentStep = 0.obs;
  final isLoading = false.obs;
  final errorMessage = RxnString();

  final farmInfo = Rxn<FarmModel>();
  final farmerInfo = Rxn<FarmerModel>();
  final userInfo = Rxn<UserModel>();

  static const totalSteps = 4;
  static const stepLabels = [
    'Personal Info',
    'Farm Details',
    'Verification',
    'Complete',
  ];

  bool get isLastStep => currentStep.value >= totalSteps - 1;
  bool get isFirstStep => currentStep.value == 0;
  double get progress => (currentStep.value + 1) / totalSteps;

  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step < totalSteps) {
      currentStep.value = step;
    }
  }

  Future<bool> savePersonalInfo({
    required String name,
    required String phone,
    required String email,
  }) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      await Future.delayed(const Duration(seconds: 1));

      userInfo.value = UserModel(
        id: 'user-${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        phone: phone,
        email: email,
        role: UserRole.farmer,
      );

      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
      return false;
    }
  }

  Future<bool> saveFarmInfo({
    required String farmName,
    required String address,
    required String description,
  }) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      await Future.delayed(const Duration(seconds: 1));

      farmInfo.value = FarmModel(
        id: 'farm-${DateTime.now().millisecondsSinceEpoch}',
        farmerId: userInfo.value?.id ?? '',
        name: farmName,
        address: address,
        description: description,
      );

      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
      return false;
    }
  }

  Future<bool> submitVerification({
    required String nationalId,
    required String farmAddress,
  }) async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      await Future.delayed(const Duration(seconds: 2));

      farmerInfo.value = FarmerModel(
        userId: userInfo.value?.id ?? '',
        farmId: farmInfo.value?.id ?? '',
        bio: 'Verified farmer',
        isVerified: true,
      );

      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
      return false;
    }
  }

  void resetOnboarding() {
    currentStep.value = 0;
    farmInfo.value = null;
    farmerInfo.value = null;
    userInfo.value = null;
  }
}
