import 'package:get/get.dart';

import 'cart_controller.dart';

class CheckoutController extends GetxController {
  final CartController cartController =
      Get.find<CartController>();

  final RxString selectedDelivery =
      'Standard'.obs;

  final RxString selectedPayment =
      'ABA Bank (Pay Direct)'.obs;

  final String customerName = 'Channa Sok';

  final String address =
      'No. 12A, St. 51, Sangkat Boeung Keng Kang 1, '
      'Khan Chamkarmon, Phnom Penh, 12302';

  void selectDelivery(String value) {
    selectedDelivery.value = value;
  }

  void selectPayment(String value) {
    selectedPayment.value = value;
  }

  double get deliveryFee {
    if (selectedDelivery.value == 'Express') {
      return 3.00;
    }

    return 2.00;
  }

  double get subtotal {
    return cartController.subtotal;
  }

  double get total {
    return subtotal + deliveryFee;
  }

  int get totalItems {
    return cartController.totalItems;
  }
}