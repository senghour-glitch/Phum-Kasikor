import 'package:get/get.dart';

import '../../model/order_model.dart';
import '../../model/cart_item_model.dart';

import 'cart_controller.dart';
import 'checkout_controller.dart';

class OrderController extends GetxController {
  final CartController cartController = Get.find<CartController>();

  final CheckoutController checkoutController = Get.find<CheckoutController>();

  // Current order
  final Rxn<OrderModel> currentOrder = Rxn<OrderModel>();

  // Order status
  final RxString orderStatus = 'Order Placed'.obs;

  void placeOrder() {
    if (cartController.cartItems.isEmpty) {
      Get.snackbar(
        'Empty Cart',
        'Please add products to your cart first.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final order = OrderModel(
      orderId: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      productName: cartController.cartItems.first.productName,
      sellerName: 'Phum Kasikor',
      customerName: checkoutController.customerName,
      phone: '',
      address: checkoutController.address,
      items: cartController.cartItems.map(_toOrderItem).toList(),
      subtotal: checkoutController.subtotal,
      deliveryFee: checkoutController.deliveryFee,
      total: checkoutController.total,
      paymentMethod: checkoutController.selectedPayment.value,
      paymentVerified: false,
      fulfillmentStage: 0,
    );

    currentOrder.value = order;

    orderStatus.value = 'Order Placed';

    Get.toNamed('/payment');
  }

  OrderItemModel _toOrderItem(CartItemModel item) {
    return OrderItemModel(
      name: item.productName,
      khmerName: item.productName,
      quantity: '${item.quantity} ${item.unit}',
      price: item.price,
    );
  }

  // =====================================================
  // PAYMENT COMPLETED
  // =====================================================

  void paymentCompleted() {
    orderStatus.value = 'Payment Confirmed';
    currentOrder.value?.fulfillmentStage = 1;

    Get.toNamed('/order-success');
  }

  // =====================================================
  // START DELIVERY
  // =====================================================

  void startDelivery() {
    orderStatus.value = 'Out for Delivery';
    currentOrder.value?.fulfillmentStage = 2;
  }

  // =====================================================
  // COMPLETE DELIVERY
  // =====================================================

  void completeDelivery() {
    orderStatus.value = 'Delivered';
    currentOrder.value?.fulfillmentStage = 3;
  }

  // =====================================================
  // UPDATE STATUS
  // =====================================================

  void updateStatus(String status) {
    orderStatus.value = status;
  }

  // =====================================================
  // ORDER ID
  // =====================================================

  String get orderId {
    return currentOrder.value?.orderId ?? 'ORD-2024-001';
  }

  // =====================================================
  // ORDER TOTAL
  // =====================================================

  double get orderTotal {
    return currentOrder.value?.total ?? 0;
  }

  // =====================================================
  // ORDER EXISTS
  // =====================================================

  bool get hasOrder {
    return currentOrder.value != null;
  }
}
