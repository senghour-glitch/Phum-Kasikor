class OrderItemModel {
  final String id;
  final String orderId;
  final String productName;
  final double price;
  final int quantity;
  final String unit;

  OrderItemModel({
    required this.id,
    required this.orderId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.unit,
  });

  OrderItemModel copyWith({
    String? id,
    String? orderId,
    String? productName,
    double? price,
    int? quantity,
    String? unit,
  }) {
    return OrderItemModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
    );
  }

  double get subtotal => price * quantity;

  Map<String, dynamic> toJson() => {
    'id': id,
    'order_id': orderId,
    'product_name': productName,
    'price': price,
    'quantity': quantity,
    'unit': unit,
  };

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
    id: json['id'] as String? ?? '',
    orderId: json['order_id'] as String? ?? '',
    productName: json['product_name'] as String? ?? '',
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    unit: json['unit'] as String? ?? 'kg',
  );
}