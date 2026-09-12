enum PaymentMethod { cashOnDelivery, khqr, card }

enum PaymentStatus { pending, paid, failed, refunded }

class PaymentModel {
  const PaymentModel({
    required this.id,
    required this.orderId,
    required this.amount,
    required this.method,
    this.status = PaymentStatus.pending,
    this.paidAt,
  });
  final String id, orderId;
  final double amount;
  final PaymentMethod method;
  final PaymentStatus status;
  final DateTime? paidAt;
  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    id: json['id'] as String,
    orderId: json['orderId'] as String,
    amount: (json['amount'] as num).toDouble(),
    method: PaymentMethod.values.byName(json['method'] as String),
    status: PaymentStatus.values.byName(json['status'] as String? ?? 'pending'),
    paidAt: json['paidAt'] == null
        ? null
        : DateTime.parse(json['paidAt'] as String),
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'orderId': orderId,
    'amount': amount,
    'method': method.name,
    'status': status.name,
    'paidAt': paidAt?.toIso8601String(),
  };
}
