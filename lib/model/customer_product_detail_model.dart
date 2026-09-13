import 'package:phum_kasikor/model/product_model.dart';

class CustomerProductDetailModel {
  const CustomerProductDetailModel({
    required this.product,
    required this.farmName,
    required this.rating,
    required this.ratingsCount,
    required this.origin,
    required this.method,
    required this.harvest,
    required this.minimumOrder,
    required this.reviews,
  });

  final ProductModel product;
  final String farmName;
  final double rating;
  final int ratingsCount;
  final String origin;
  final String method;
  final String harvest;
  final int minimumOrder;
  final List<ProductReviewModel> reviews;
}

class ProductReviewModel {
  const ProductReviewModel({
    required this.name,
    required this.rating,
    required this.comment,
  });

  final String name;
  final int rating;
  final String comment;

  String get initials => name
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .map((part) => part[0])
      .take(2)
      .join();
}
