import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/color/color.dart';
import 'package:phum_kasikor/controllers/customer/customer_order_flow_controller.dart';

class CustomerOrderTrackingScreen extends StatelessWidget {
  const CustomerOrderTrackingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final c = Get.find<CustomerOrderFlowController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Track Order #${c.orderNumber.value}',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _card(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Delivery Status',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 13),
                _Status('Order Placed', 'Jul 12, 10:30 AM', complete: true),
                _Status(
                  'Payment Confirmed',
                  'Jul 12, 10:32 AM',
                  complete: true,
                ),
                _Status('Preparing Order', 'Jul 12, 2:00 PM', complete: true),
                _Status('Out for Delivery', 'Jul 15, 8:00 AM', active: true),
                _Status('Delivered', 'Pending'),
              ],
            ),
          ),
          const Text(
            'Delivery Route',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            height: 145,
            decoration: BoxDecoration(
              color: AppColors.mapBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(
                    Icons.map_outlined,
                    size: 78,
                    color: AppColors.mapRoad,
                  ),
                ),
                Positioned(left: 34, top: 28, child: _pin(AppColors.primary)),
                Positioned(right: 38, bottom: 26, child: _pin(AppColors.error)),
                const Center(
                  child: Text(
                    'Live delivery route',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _card(
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFDAB7A5),
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 9),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sokha Vann',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Your Farmer • Sokha's Organic Farm",
                        style: TextStyle(
                          fontSize: 9,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.phone_outlined,
                    color: AppColors.primary,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chat_bubble_outline,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          _card(
            const Text(
              'Jasmine Rice, Morning Glory + 1 more',
              style: TextStyle(fontSize: 10),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 42,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Contact Farmer',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Status extends StatelessWidget {
  const _Status(
    this.title,
    this.time, {
    this.complete = false,
    this.active = false,
  });
  final String title, time;
  final bool complete, active;
  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Icon(
            complete
                ? Icons.check_circle
                : active
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            size: 15,
            color: complete
                ? AppColors.primary
                : active
                ? AppColors.warning
                : AppColors.borderStrong,
          ),
          Container(width: 1, height: 21, color: AppColors.border),
        ],
      ),
      const SizedBox(width: 9),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                fontWeight: active ? FontWeight.bold : null,
              ),
            ),
            Text(
              time,
              style: const TextStyle(
                fontSize: 9,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _pin(Color color) =>
    Icon(Icons.location_on_rounded, color: color, size: 25);
Widget _card(Widget child) => Container(
  margin: const EdgeInsets.only(bottom: 12),
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.white,
    border: Border.all(color: AppColors.border),
    borderRadius: BorderRadius.circular(10),
  ),
  child: child,
);
