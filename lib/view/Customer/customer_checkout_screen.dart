import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/color/color.dart';
import 'package:phum_kasikor/controllers/customer/customer_order_flow_controller.dart';
import 'package:phum_kasikor/core/routes/app_routes.dart';

class CustomerCheckoutScreen extends StatelessWidget {
  const CustomerCheckoutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final c = Get.find<CustomerOrderFlowController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
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
                  const _Section(
                    title: 'Delivery Address',
                    child: Text(
                      'Channa Sok\nNo. 124, St. 51, Sangkat Boeung Keng Kang 1,\nKhan Chamkarmon, Phnom Penh, 12302',
                      style: _body,
                    ),
                  ),
                  _Section(
                    title: 'Delivery Method',
                    child: Row(
                      children: [
                        Expanded(
                          child: _Choice(
                            label: 'Standard\n2–3 Days • Free',
                            selected: c.selectedDelivery.value == 'Standard',
                            onTap: () => c.chooseDelivery('Standard'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _Choice(
                            label: 'Express\nSame Day • \$3.00',
                            selected: c.selectedDelivery.value == 'Express',
                            onTap: () => c.chooseDelivery('Express'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _Section(
                    title: '${c.cart.length} Items Selected',
                    child: Column(
                      children: c.cart
                          .map(
                            (x) => _line(
                              '${x.name} × ${x.quantity}',
                              '\$${(x.price * x.quantity).toStringAsFixed(2)}',
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const Text(
                    'Pay Farmer Directly',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 7),
                  ...[
                    'ABA Bank (Pay Direct)',
                    'Wing Money',
                    'Bakong (KHQR) Direct',
                    'Credit/Debit Card',
                    'Cash on Delivery',
                  ].map(
                    (method) => _PaymentChoice(
                      label: method,
                      selected: c.selectedPayment.value == method,
                      onTap: () => c.choosePayment(method),
                    ),
                  ),
                  const _Section(
                    title: 'Order Note (Optional)',
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Add delivery requests or instructions',
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _BottomButton(
              label: 'Place Order — \$${c.total.toStringAsFixed(2)}',
              onTap: () => Get.toNamed(AppRoutes.customerPayment),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(11),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: AppColors.border),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        child,
      ],
    ),
  );
}

class _Choice extends StatelessWidget {
  const _Choice({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: selected ? AppColors.primaryLight : Colors.white,
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.border,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(label, style: const TextStyle(fontSize: 9)),
    ),
  );
}

class _PaymentChoice extends StatelessWidget {
  const _PaymentChoice({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 7),
    child: InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 16,
              color: selected ? AppColors.primary : AppColors.textHint,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    ),
  );
}

class _BottomButton extends StatelessWidget {
  const _BottomButton({required this.label, required this.onTap});
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

Widget _line(String left, String right) => Padding(
  padding: const EdgeInsets.symmetric(vertical: 3),
  child: Row(
    children: [
      Expanded(child: Text(left, style: _body)),
      Text(
        right,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    ],
  ),
);
const _body = TextStyle(
  fontSize: 10,
  height: 1.4,
  color: AppColors.textSecondary,
);
