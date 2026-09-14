class CartItemModel {
  final String id;
  final String productId;
  final String productName;
  final double price;
  final int quantity;
  final String unit;
  final String? imageUrl;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.unit,
    this.imageUrl,
  });

  CartItemModel copyWith({
    String? id,
    String? productId,
    String? productName,
    double? price,
    int? quantity,
    String? unit,
    String? imageUrl,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  double get subtotal => price * quantity;

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_id': productId,
    'product_name': productName,
    'price': price,
    'quantity': quantity,
    'unit': unit,
    'image_url': imageUrl,
  };

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
    id: json['id'] as String? ?? '',
    productId: json['product_id'] as String? ?? '',
    productName: json['product_name'] as String? ?? '',
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    unit: json['unit'] as String? ?? 'kg',
    imageUrl: json['image_url'] as String?,
  );

 
}