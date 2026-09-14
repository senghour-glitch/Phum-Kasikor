import 'cart_item_model.dart';

enum DeliveryMethod { standard, express }

enum PaymentMethod {
  abaBank,
  wingMoney,
  bakongKhqr,
  creditCard,
  cashOnDelivery,
}

enum OrderStatus {
  placed,
  paymentConfirmed,
  preparing,
  outForDelivery,
  delivered,
  cancelled,
}

extension PaymentMethodX on PaymentMethod {
  String get label {
    switch (this) {
      case PaymentMethod.abaBank:
        return 'ABA Bank (Pay Direct)';
      case PaymentMethod.wingMoney:
        return 'Wing Money';
      case PaymentMethod.bakongKhqr:
        return 'Bakong (KHQR Direct)';
      case PaymentMethod.creditCard:
        return 'Credit/Debit Card';
      case PaymentMethod.cashOnDelivery:
        return 'Cash on Delivery';
    }
  }

  bool get isDirectFarmPayment =>
      this == PaymentMethod.abaBank ||
      this == PaymentMethod.wingMoney ||
      this == PaymentMethod.bakongKhqr;
}

extension OrderStatusX on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.placed:
        return 'Order Placed';
      case OrderStatus.paymentConfirmed:
        return 'Payment Confirmed';
      case OrderStatus.preparing:
        return 'Preparing Order';
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class OrderModel {
  final String id;
  final String referenceNumber;
  final List<CartItemModel> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final DeliveryMethod deliveryMethod;
  final PaymentMethod paymentMethod;
  final String deliveryAddress;
  final String? orderNote;
  final String farmName;
  final String farmerName;
  final String? farmerPhone;
  OrderStatus status;
  final DateTime orderDate;
  final DateTime? estimatedDelivery;

  OrderModel({
    required this.id,
    required this.referenceNumber,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.deliveryMethod,
    required this.paymentMethod,
    required this.deliveryAddress,
    this.orderNote,
    required this.farmName,
    required this.farmerName,
    this.farmerPhone,
    this.status = OrderStatus.placed,
    required this.orderDate,
    this.estimatedDelivery,
  });

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
}
