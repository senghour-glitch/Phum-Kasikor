import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/controllers/customer/order_controller.dart';

class OrderTrackingView extends StatelessWidget {
  OrderTrackingView({super.key});

  final OrderController controller =
      Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),
      ),

      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Order #${controller.orderId}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Status: ${controller.orderStatus.value}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              _status(
                'Order Placed',
                true,
              ),

              _status(
                'Payment Confirmed',
                controller.orderStatus.value ==
                        'Payment Confirmed' ||
                    controller.orderStatus.value ==
                        'Out for Delivery' ||
                    controller.orderStatus.value ==
                        'Delivered',
              ),

              _status(
                'Out for Delivery',
                controller.orderStatus.value ==
                        'Out for Delivery' ||
                    controller.orderStatus.value ==
                        'Delivered',
              ),

              _status(
                'Delivered',
                controller.orderStatus.value ==
                    'Delivered',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _status(
    String title,
    bool completed,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 25),
      child: Row(
        children: [
          Icon(
            completed
                ? Icons.check_circle
                : Icons.circle_outlined,
            color:
                completed ? Colors.green : Colors.grey,
            size: 30,
          ),

          const SizedBox(width: 15),

          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight:
                  completed ? FontWeight.bold : null,
            ),
          ),
        ],
      ),
    );
  }
}