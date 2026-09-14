import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/controllers/customer/customer_search_controller.dart';


class CustomerSearchFilterScreen extends StatelessWidget {
  const CustomerSearchFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.find<CustomerSearchController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search & Filter'),
        actions: [
          TextButton(
            onPressed: controller.clearFilters,
            child: const Text('Clear All'),
          ),
        ],
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
              onChanged: controller.search,
              decoration: InputDecoration(
                hintText: 'Organic vegetables',
                prefixIcon:
                    const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              '${controller.filteredProducts.length} products found',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 16),

            ...controller.filteredProducts.map(
              (product) => Card(
                child: ListTile(
                  leading: Image.asset(
                    product.image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.name),
                  subtitle: Text(
                    '${product.farmName}\n'
                    '\$${product.price.toStringAsFixed(2)}/${product.unit}',
                  ),
                  trailing: Text(
                    '⭐ ${product.rating}',
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Filter Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text('Price Range'),

            RangeSlider(
              min: 0,
              max: 50,
              divisions: 50,
              values: RangeValues(
                controller.minPrice.value,
                controller.maxPrice.value,
              ),
              onChanged: (value) {
                controller.setPriceRange(
                  value.start,
                  value.end,
                );
              },
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${controller.minPrice.value.toStringAsFixed(0)}',
                ),
                Text(
                  '\$${controller.maxPrice.value.toStringAsFixed(0)}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}