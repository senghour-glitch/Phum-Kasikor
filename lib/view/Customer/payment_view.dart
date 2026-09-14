import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/customer/order_controller.dart';

class PaymentView extends StatelessWidget {
  PaymentView({super.key});

  final OrderController controller =
      Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 30),

            const Icon(
              Icons.account_balance,
              size: 90,
              color: Colors.blue,
            ),

            const SizedBox(height: 25),

            const Text(
              'ABA Bank Payment',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              'Order: ${controller.orderId}',
            ),

            const SizedBox(height: 10),

            Text(
              '\$${controller.orderTotal.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  controller.paymentCompleted();
                },
                child: const Text(
                  'Confirm Payment',
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}