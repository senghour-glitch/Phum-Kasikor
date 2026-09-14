import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/controllers/customer/customer_home_controller.dart';


class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomerHomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Home'),
      ),

      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Browse Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  final category =
                      controller.categories[index];

                  return GestureDetector(
                    onTap: () {
                      controller.selectCategory(
                        category.name,
                      );
                    },
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.only(
                        right: 12,
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            child: Text(
                              category.icon,
                              style: const TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            category.name,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Fresh Today',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            ...controller.freshProducts.map(
              (product) => ListTile(
                leading: Image.asset(
                  product.image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(product.name),
                subtitle: Text(
                  '${product.price.toStringAsFixed(2)} / ${product.unit}',
                ),
                trailing: const Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}