import 'package:phum_kasikor/model/customer/product_model.dart';

class CartItemModel {
  final ProductModel product;
  int quantity;

  CartItemModel({
    required this.product,
    this.quantity = 1,
  });

  double get totalPrice {
    return product.price * quantity;
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': product.id,
      'productName': product.name,
      'price': product.price,
      'unit': product.unit,
      'quantity': quantity,
      'totalPrice': totalPrice,
    };
  }
}