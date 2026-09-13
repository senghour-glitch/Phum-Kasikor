import 'order_item_model.dart';

class OrderModel {
  final String id;
  final String farmerId;
  final String farmerName;
  final String status;
  final double totalAmount;
  final String deliveryAddress;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.farmerId,
    required this.farmerName,
    required this.status,
    required this.totalAmount,
    required this.deliveryAddress,
    required this.createdAt,
    this.updatedAt,
    required this.items,
  });

  OrderModel copyWith({
    String? id,
    String? farmerId,
    String? farmerName,
    String? status,
    double? totalAmount,
    String? deliveryAddress,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<OrderItemModel>? items,
  }) {
    return OrderModel(
      id: id ?? this.id,
      farmerId: farmerId ?? this.farmerId,
      farmerName: farmerName ?? this.farmerName,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'farmer_id': farmerId,
    'farmer_name': farmerName,
    'status': status,
    'total_amount': totalAmount,
    'delivery_address': deliveryAddress,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'items': items.map((e) => e.toJson()).toList(),
  };

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json['id'] as String? ?? '',
    farmerId: json['farmer_id'] as String? ?? '',
    farmerName: json['farmer_name'] as String? ?? '',
    status: json['status'] as String? ?? 'pending',
    totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
    deliveryAddress: json['delivery_address'] as String? ?? '',
    createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at'] as String) ?? DateTime.now() : DateTime.now(),
    updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at'] as String) : null,
    items: json['items'] != null
        ? (json['items'] as List).map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>)).toList()
        : [],
  );
}