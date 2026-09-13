class PaymentModel {
  final String id;
  final String orderId;
  final String method;
  final double amount;
  final String status;
  final DateTime createdAt;
  final String? referenceNumber;
  final Map<String, dynamic>? metadata;

  PaymentModel({
    required this.id,
    required this.orderId,
    required this.method,
    required this.amount,
    required this.status,
    required this.createdAt,
    this.referenceNumber,
    this.metadata,
  });

  PaymentModel copyWith({
    String? id,
    String? orderId,
    String? method,
    double? amount,
    String? status,
    DateTime? createdAt,
    String? referenceNumber,
    Map<String, dynamic>? metadata,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      method: method ?? this.method,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      metadata: metadata ?? this.metadata,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'order_id': orderId,
    'method': method,
    'amount': amount,
    'status': status,
    'created_at': createdAt.toIso8601String(),
    'reference_number': referenceNumber,
    'metadata': metadata,
  };

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
    id: json['id'] as String? ?? '',
    orderId: json['order_id'] as String? ?? '',
    method: json['method'] as String? ?? '',
    amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
    status: json['status'] as String? ?? 'pending',
    createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at'] as String) ?? DateTime.now() : DateTime.now(),
    referenceNumber: json['reference_number'] as String?,
    metadata: json['metadata'] as Map<String, dynamic>?,
  );
}