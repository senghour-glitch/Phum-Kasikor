import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/color/color.dart';
import 'package:phum_kasikor/controllers/customer/customer_order_flow_controller.dart';
import 'package:phum_kasikor/core/routes/app_routes.dart';

class CustomerOrderSuccessScreen extends StatelessWidget {
  const CustomerOrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomerOrderFlowController>();
    return Scaffold(
      backgroundColor: const Color(0xFFFCFBF8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 28, 18, 16),
          child: Column(
            children: [
              const _SuccessHeader(),
              const SizedBox(height: 13),
              Text(
                'Order Reference #${controller.orderNumber.value}',
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 14),
              _Receipt(controller: controller),
              const SizedBox(height: 12),
              const _DeliveryEstimate(),
              const SizedBox(height: 14),
              _ActionButton(
                label: 'Track Order',
                onPressed: () => Get.offNamed(AppRoutes.customerOrderTracking),
              ),
              const SizedBox(height: 9),
              _ActionButton(
                label: 'Continue Shopping',
                outlined: true,
                onPressed: () => Get.offAllNamed(AppRoutes.customerHome),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Download Receipt',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                width: 100,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6D6D3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuccessHeader extends StatelessWidget {
  const _SuccessHeader();
  @override
  Widget build(BuildContext context) => Column(
    children: const [
      CircleAvatar(
        radius: 32,
        backgroundColor: AppColors.primaryLight,
        child: Icon(
          Icons.verified_outlined,
          color: AppColors.primary,
          size: 32,
        ),
      ),
      SizedBox(height: 16),
      Text(
        'Order Placed Successfully!',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
        ),
      ),
    ],
  );
}

class _Receipt extends StatelessWidget {
  const _Receipt({required this.controller});
  final CustomerOrderFlowController controller;

  @override
  Widget build(BuildContext context) => _Card(
    child: Column(
      children: [
        _ReceiptRow('Date', 'Jul 12, 2024'),
        _ReceiptRow('Payment Method', 'ABA Bank (Direct)'),
        const _ReceiptRow('Paid To', "Sokha's Organic Farm", green: true),
        const Divider(height: 15),
        ...controller.cart.map(
          (line) => _ReceiptRow(
            '${line.name.replaceFirst('Fresh ', '')} × ${line.quantity}',
            '\$${(line.price * line.quantity).toStringAsFixed(2)}',
          ),
        ),
        const Divider(height: 15),
        _ReceiptRow('Subtotal', '\$${controller.subtotal.toStringAsFixed(2)}'),
        _ReceiptRow(
          'Delivery',
          '\$${controller.deliveryFee.toStringAsFixed(2)}',
        ),
        const Divider(height: 15),
        _ReceiptRow(
          'Total Amount',
          '\$${controller.total.toStringAsFixed(2)}',
          bold: true,
          green: true,
        ),
      ],
    ),
  );
}

class _ReceiptRow extends StatelessWidget {
  const _ReceiptRow(
    this.label,
    this.value, {
    this.bold = false,
    this.green = false,
  });
  final String label, value;
  final bool bold, green;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: bold ? AppColors.textPrimary : AppColors.textSecondary,
            fontWeight: bold ? FontWeight.w800 : FontWeight.normal,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 10,
            color: green ? AppColors.primary : AppColors.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}

class _DeliveryEstimate extends StatelessWidget {
  const _DeliveryEstimate();
  @override
  Widget build(BuildContext context) => const _Card(
    child: Row(
      children: [
        Icon(Icons.local_shipping_outlined, color: AppColors.primary, size: 20),
        SizedBox(width: 9),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estimated Delivery',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
            Text(
              'Tuesday, Jul 15, 2024',
              style: TextStyle(fontSize: 9, color: AppColors.textSecondary),
            ),
          ],
        ),
      ],
    ),
  );
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: AppColors.border),
      borderRadius: BorderRadius.circular(12),
    ),
    child: child,
  );
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.onPressed,
    this.outlined = false,
  });
  final String label;
  final VoidCallback onPressed;
  final bool outlined;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 43,
    child: outlined
        ? OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary),
            ),
            child: Text(
              label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            child: Text(
              label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
  );
}
