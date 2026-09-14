import 'package:get/get.dart';
import 'package:phum_kasikor/model/customer/cart_item_model.dart';
import 'package:phum_kasikor/model/customer/product_model.dart';

class CustomerCartController extends GetxController {
  final cartItems = <CartItemModel>[].obs;

  int get totalItems {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  void addToCart(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      cartItems[index].quantity++;
      cartItems.refresh();
    } else {
      cartItems.add(CartItemModel(product: product, quantity: 1));
    }

    Get.snackbar(
      'Added to Cart',
      product.name,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void increaseQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index].quantity++;
      cartItems.refresh();
    }
  }

  void decreaseQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
        cartItems.refresh();
      }
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems.removeAt(index);
    }
  }

  void clearCart() {
    cartItems.clear();
  }

  void checkout() {
    if (cartItems.isEmpty) {
      Get.snackbar(
        'Cart Empty',
        'Please add products first',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.snackbar(
      'Order Created',
      'Your order has been placed successfully',
      snackPosition: SnackPosition.BOTTOM,
    );

    clearCart();
  }
}
