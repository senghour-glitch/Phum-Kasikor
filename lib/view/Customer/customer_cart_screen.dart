import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/color/color.dart';
import 'package:phum_kasikor/controllers/customer/customer_order_flow_controller.dart';
import 'package:phum_kasikor/core/routes/app_routes.dart';

class CustomerCartScreen extends StatelessWidget {
  const CustomerCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(CustomerOrderFlowController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    '${c.cart.length} items',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...c.cart.asMap().entries.map(
                    (entry) => _CartLine(
                      line: entry.value,
                      onMinus: () => c.changeQuantity(entry.key, -1),
                      onPlus: () => c.changeQuantity(entry.key, 1),
                    ),
                  ),
                  const _PromoField(),
                  _Summary(
                    subtotal: c.subtotal,
                    delivery: c.deliveryFee,
                    total: c.total,
                  ),
                ],
              ),
            ),
            _PrimaryButton(
              label: 'Proceed to Checkout — \$${c.total.toStringAsFixed(2)}',
              onTap: () => Get.toNamed(AppRoutes.customerCheckout),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartLine extends StatelessWidget {
  const _CartLine({
    required this.line,
    required this.onMinus,
    required this.onPlus,
  });
  final CartLineModel line;
  final VoidCallback onMinus, onPlus;
  @override
  Widget build(BuildContext context) => _Card(
    child: Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFE7E1C9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.shopping_basket_outlined,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                line.name,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                line.farm,
                style: const TextStyle(
                  fontSize: 9,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '\$${line.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: onMinus,
                  icon: const Icon(Icons.remove, size: 14),
                ),
                Text(
                  '${line.quantity}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: onPlus,
                  icon: const Icon(Icons.add, size: 14),
                ),
              ],
            ),
            Text(
              '\$${(line.quantity * line.price).toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    ),
  );
}

class _PromoField extends StatelessWidget {
  const _PromoField();
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        const Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Enter promo code',
              isDense: true,
              contentPadding: EdgeInsets.all(11),
            ),
          ),
        ),
        const SizedBox(width: 8),
        FilledButton(onPressed: () {}, child: const Text('Apply')),
      ],
    ),
  );
}

class _Summary extends StatelessWidget {
  const _Summary({
    required this.subtotal,
    required this.delivery,
    required this.total,
  });
  final double subtotal, delivery, total;
  @override
  Widget build(BuildContext context) => _Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
        const Divider(),
        _row('Subtotal', subtotal),
        _row('Delivery Fee', delivery),
        const Divider(),
        _row('Total Amount', total, bold: true, green: true),
      ],
    ),
  );
  Widget _row(
    String label,
    double value, {
    bool bold = false,
    bool green = false,
  }) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: bold ? FontWeight.bold : null,
          ),
        ),
        const Spacer(),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 10,
            fontWeight: bold ? FontWeight.bold : null,
            color: green ? AppColors.primary : null,
          ),
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
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: AppColors.border),
      borderRadius: BorderRadius.circular(10),
    ),
    child: child,
  );
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
    child: SizedBox(
      width: double.infinity,
      height: 43,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
