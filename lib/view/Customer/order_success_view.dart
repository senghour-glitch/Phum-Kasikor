import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/controllers/customer/cart_controller.dart';


class OrderSuccessView extends StatelessWidget {
  OrderSuccessView({super.key});

  final CartController cartController =
      Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                size: 100,
                color: Colors.green,
              ),

              const SizedBox(height: 25),

              const Text(
                'Order Successful!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Your order has been placed successfully.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    cartController.clearCart();
                    Get.offAllNamed('/');
                  },
                  child: const Text(
                    'Continue Shopping',
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    cartController.clearCart();
                    Get.toNamed('/order-tracking');
                  },
                  child: const Text(
                    'Track Order',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}