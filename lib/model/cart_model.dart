import 'cart_item_model.dart';

class CartModel {
  final String id;
  final String userId;
  final List<CartItemModel> items;
  final DateTime createdAt;
  final DateTime? updatedAt;

  CartModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.createdAt,
    this.updatedAt,
  });

  CartModel copyWith({
    String? id,
    String? userId,
    List<CartItemModel>? items,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CartModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  double get subtotal => items.fold(0, (sum, item) => sum + item.price * item.quantity);

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'items': items.map((e) => e.toJson()).toList(),
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
  };

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json['id'] as String? ?? '',
    userId: json['user_id'] as String? ?? '',
    items: json['items'] != null
        ? (json['items'] as List).map((e) => CartItemModel.fromJson(e as Map<String, dynamic>)).toList()
        : [],
    createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at'] as String) ?? DateTime.now() : DateTime.now(),
    updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at'] as String) : null,
  );
}