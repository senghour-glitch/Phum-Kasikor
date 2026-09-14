class ProductModel {
  final String id;
  final String name;
  final String image;
  final String farmName;
  final double price;
  final String unit;
  final double rating;
  final int reviewCount;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.farmName,
    required this.price,
    required this.unit,
    required this.rating,
    required this.reviewCount,
  });

  factory ProductModel.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return ProductModel(
      id: id,
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      farmName: map['farmName'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      unit: map['unit'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      reviewCount: map['reviewCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'farmName': farmName,
      'price': price,
      'unit': unit,
      'rating': rating,
      'reviewCount': reviewCount,
    };
  }
}