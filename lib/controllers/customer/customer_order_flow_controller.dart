import 'package:get/get.dart';

class CartLineModel {
  const CartLineModel({
    required this.name,
    required this.farm,
    required this.price,
    required this.quantity,
  });

  final String name;
  final String farm;
  final double price;
  final int quantity;

  CartLineModel copyWith({int? quantity}) => CartLineModel(
        name: name,
        farm: farm,
        price: price,
        quantity: quantity ?? this.quantity,
      );
}

class CustomerOrderFlowController extends GetxController {
  final cart = <CartLineModel>[
    const CartLineModel(name: 'Fresh Jasmine Rice', farm: "Sokha's Organic Farm", price: 2.50, quantity: 2),
    const CartLineModel(name: 'Organic Morning Glory', farm: "Sokha's Organic Farm", price: 1.00, quantity: 3),
    const CartLineModel(name: 'Natural Palm Sugar', farm: 'Bantang Sweet Fruit', price: 5.00, quantity: 1),
  ].obs;

  final selectedPayment = 'ABA Bank (Pay Direct)'.obs;
  final selectedDelivery = 'Standard'.obs;
  final paymentConfirmed = false.obs;
  final orderNumber = 'ORD-2024-001'.obs;

  double get subtotal => cart.fold(0, (total, item) => total + item.price * item.quantity);
  double get deliveryFee => subtotal >= 15 ? 0 : 2;
  double get total => subtotal + deliveryFee;

  void changeQuantity(int index, int delta) {
    final line = cart[index];
    final amount = line.quantity + delta;
    if (amount <= 0) {
      cart.removeAt(index);
    } else {
      cart[index] = line.copyWith(quantity: amount);
    }
  }

  void choosePayment(String payment) => selectedPayment.value = payment;
  void chooseDelivery(String delivery) => selectedDelivery.value = delivery;
  void confirmPayment() => paymentConfirmed.value = true;
}
