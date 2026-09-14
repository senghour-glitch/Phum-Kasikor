import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/controllers/customer/customer_farm_controller.dart';

class CustomerFarmMapScreen extends StatelessWidget {
  const CustomerFarmMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomerFarmController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Farm Map')),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                // Replace this with GoogleMap later
                Container(
                  width: double.infinity,
                  color: Colors.green.shade100,
                  child: const Center(
                    child: Icon(Icons.map, size: 100, color: Colors.green),
                  ),
                ),

                Positioned(
                  top: 16,
                  left: 16,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Map View'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('List View'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.agriculture, size: 45, color: Colors.green),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sokha's Organic Farm",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Kandal Province • 2.3 km away'),
                      Text('⭐ 4.8 • 24 Products'),
                    ],
                  ),
                ),
                ElevatedButton(onPressed: () {}, child: const Text('Open')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
