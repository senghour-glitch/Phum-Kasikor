class ProductModel {
  final String id;
  final String farmId;
  final String name;
  final double price;
  final String unit;
  final int stock;
  final String description;

  ProductModel({
    required this.id,
    required this.farmId,
    required this.name,
    required this.price,
    required this.unit,
    required this.stock,
    required this.description,
  });

  ProductModel copyWith({
    String? id,
    String? farmId,
    String? name,
    double? price,
    String? unit,
    int? stock,
    String? description,
  }) {
    return ProductModel(
      id: id ?? this.id,
      farmId: farmId ?? this.farmId,
      name: name ?? this.name,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      stock: stock ?? this.stock,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'farm_id': farmId,
    'name': name,
    'price': price,
    'unit': unit,
    'stock': stock,
    'description': description,
  };

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] as String,
    farmId: json['farm_id'] as String? ?? '',
    name: json['name'] as String? ?? '',
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    unit: json['unit'] as String? ?? 'kg',
    stock: (json['stock'] as num?)?.toInt() ?? 0,
    description: json['description'] as String? ?? '',
  );
}