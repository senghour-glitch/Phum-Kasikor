import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/color/color.dart';
import 'package:phum_kasikor/controllers/customer/customer_order_flow_controller.dart';
import 'package:phum_kasikor/core/routes/app_routes.dart';

class CustomerPaymentScreen extends StatelessWidget {
  const CustomerPaymentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final c = Get.find<CustomerOrderFlowController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Direct Payment',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Center(
              child: Chip(
                label: const Text(
                  'Direct Farm Payment • No Fees',
                  style: TextStyle(fontSize: 10),
                ),
                backgroundColor: AppColors.primaryLight,
                side: BorderSide.none,
              ),
            ),
            const SizedBox(height: 16),
            _panel(
              Column(
                children: [
                  _row('Farmer Payee', 'Sokha Vann'),
                  const Divider(),
                  _row('Farm Shop', "Sokha's Organic Farm", green: true),
                  const Divider(),
                  _row('Payment Reference', c.orderNumber.value),
                  const Divider(),
                  _row(
                    'Amount Due',
                    '\$${c.total.toStringAsFixed(2)}',
                    green: true,
                    large: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _panel(
              Column(
                children: [
                  const SizedBox(height: 8),
                  Container(
                    width: 116,
                    height: 116,
                    color: Colors.white,
                    child: const Center(
                      child: Icon(Icons.qr_code_2_rounded, size: 96),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Scan KHQR to Pay directly',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '⏱  14:53 left to complete payment',
                    style: TextStyle(fontSize: 10, color: AppColors.error),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _panel(
              const Text(
                'Or Bank Transfer Details\nABA Account:  001 123 456 (Sokha Vann)',
                style: TextStyle(fontSize: 10, height: 1.5),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 43,
              child: ElevatedButton(
                onPressed: () {
                  c.confirmPayment();
                  Get.offNamed(AppRoutes.customerOrderSuccess);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "I've Completed Payment",
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            TextButton(
              onPressed: Get.back,
              child: const Text(
                'Cancel Order',
                style: TextStyle(color: AppColors.error, fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _panel(Widget child) => Container(
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.white,
    border: Border.all(color: AppColors.border),
    borderRadius: BorderRadius.circular(10),
  ),
  child: child,
);
Widget _row(
  String label,
  String value, {
  bool green = false,
  bool large = false,
}) => Row(
  children: [
    Text(
      label,
      style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
    ),
    const Spacer(),
    Text(
      value,
      style: TextStyle(
        fontSize: large ? 16 : 10,
        fontWeight: FontWeight.bold,
        color: green ? AppColors.primary : AppColors.textPrimary,
      ),
    ),
  ],
);
