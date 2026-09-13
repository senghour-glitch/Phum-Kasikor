class CategoryModel {
  final String id;
  final String name;
  final String? imageUrl;
  final String? description;
  final int? productCount;

  CategoryModel({
    required this.id,
    required this.name,
    this.imageUrl,
    this.description,
    this.productCount,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? description,
    int? productCount,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      productCount: productCount ?? this.productCount,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image_url': imageUrl,
    'description': description,
    'product_count': productCount,
  };

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'] as String? ?? '',
    name: json['name'] as String? ?? '',
    imageUrl: json['image_url'] as String?,
    description: json['description'] as String?,
    productCount: (json['product_count'] as num?)?.toInt(),
  );
}