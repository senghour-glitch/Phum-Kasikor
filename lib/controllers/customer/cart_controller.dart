import 'package:get/get.dart';
import 'package:phum_kasikor/model/cart_item_model.dart';
import 'package:phum_kasikor/model/customer/product_model.dart';

class CartController extends GetxController {
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  int get totalItems {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  double get subtotal => totalPrice;

  double get deliveryFee => 2.00;

  double get total => subtotal + deliveryFee;

  bool get isEmpty => cartItems.isEmpty;

  void addToCart(ProductModel product) {
    final index = cartItems.indexWhere((item) => item.productId == product.id);

    if (index != -1) {
      cartItems[index] = cartItems[index].copyWith(
        quantity: cartItems[index].quantity + 1,
      );
      cartItems.refresh();
    } else {
      cartItems.add(
        CartItemModel(
          id: product.id,
          productId: product.id,
          productName: product.name,
          price: product.price,
          quantity: 1,
          unit: product.unit,
          imageUrl: product.image,
        ),
      );
    }

    Get.snackbar(
      'Added to Cart',
      product.name,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void increaseQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index] = cartItems[index].copyWith(
        quantity: cartItems[index].quantity + 1,
      );
    }
  }

  void decreaseQuantity(int index) {
    if (index >= 0 && index < cartItems.length) {
      if (cartItems[index].quantity > 1) {
        cartItems[index] = cartItems[index].copyWith(
          quantity: cartItems[index].quantity - 1,
        );
      } else {
        cartItems.removeAt(index);
      }
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < cartItems.length) {
      cartItems.removeAt(index);
    }
  }

  void removeFromCart(ProductModel product) {
    cartItems.removeWhere((item) => item.productId == product.id);
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
