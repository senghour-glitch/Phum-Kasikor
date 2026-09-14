import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/controllers/customer/checkout_controller.dart';
import 'package:phum_kasikor/controllers/customer/order_controller.dart';


class CheckoutView extends StatelessWidget {
  CheckoutView({super.key});

  final CheckoutController controller =
      Get.find<CheckoutController>();

  final OrderController orderController =
      Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),

      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Delivery Address',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.location_on,
                    color: Colors.green,
                  ),
                  title: Text(
                    controller.customerName,
                  ),
                  subtitle: Text(
                    controller.address,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Delivery Method',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              RadioListTile<String>(
                title: const Text('Standard'),
                subtitle:
                    const Text('\$2.00 delivery'),
                value: 'Standard',
                groupValue:
                    controller.selectedDelivery.value,
                onChanged: (value) {
                  controller.selectDelivery(value!);
                },
              ),

              RadioListTile<String>(
                title: const Text('Express'),
                subtitle:
                    const Text('\$3.00 delivery'),
                value: 'Express',
                groupValue:
                    controller.selectedDelivery.value,
                onChanged: (value) {
                  controller.selectDelivery(value!);
                },
              ),

              const SizedBox(height: 15),

              const Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              RadioListTile<String>(
                title:
                    const Text('ABA Bank (Pay Direct)'),
                value:
                    'ABA Bank (Pay Direct)',
                groupValue:
                    controller.selectedPayment.value,
                onChanged: (value) {
                  controller.selectPayment(value!);
                },
              ),

              RadioListTile<String>(
                title:
                    const Text('Cash on Delivery'),
                value: 'Cash on Delivery',
                groupValue:
                    controller.selectedPayment.value,
                onChanged: (value) {
                  controller.selectPayment(value!);
                },
              ),

              const Divider(height: 35),

              _row(
                'Subtotal',
                controller.subtotal,
              ),

              _row(
                'Delivery',
                controller.deliveryFee,
              ),

              const Divider(),

              _row(
                'Total',
                controller.total,
                bold: true,
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    orderController.placeOrder();
                  },
                  child: const Text(
                    'Place Order',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(
    String title,
    double value, {
    bool bold = false,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight:
                  bold ? FontWeight.bold : null,
            ),
          ),
          Text(
            '\$${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight:
                  bold ? FontWeight.bold : null,
              fontSize: bold ? 19 : 15,
            ),
          ),
        ],
      ),
    );
  }
}