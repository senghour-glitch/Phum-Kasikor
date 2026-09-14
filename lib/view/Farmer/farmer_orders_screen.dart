import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/farmer_controller.dart';
import '../../widgets/farmer/order_card.dart';
import 'farmer_order_detail_screen.dart';
import 'farmer_ui.dart';

class FarmerOrdersScreen extends StatelessWidget {
  const FarmerOrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final farmer = Get.find<FarmerController>();
    return FarmerPage(
      title: 'Orders',
      child: Obx(
        () => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Manage new, preparing, and completed orders.',
              style: TextStyle(color: Color(0xFF718074)),
            ),
            const SizedBox(height: 16),
            ...farmer.orders.map(
              (order) => FarmerOrderCard(
                order: order,
                onTap: () =>
                    Get.to(() => FarmerOrderDetailScreen(orderId: order.id)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
