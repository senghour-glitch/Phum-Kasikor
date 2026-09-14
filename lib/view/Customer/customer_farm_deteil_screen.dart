import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/controllers/customer/customer_farm_controller.dart';


class CustomerFarmDetailScreen extends StatelessWidget {
  const CustomerFarmDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.find<CustomerFarmController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Farm Detail'),
      ),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/farm1.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Sokha's Organic Farm ✓",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: controller.toggleFollow,
                  child: Text(
                    controller.isFollowing.value
                        ? 'Following'
                        : 'Follow',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            const Text(
              'Kandal Province • Organic Certified',
            ),

            const SizedBox(height: 8),

            const Text(
              '⭐ 4.8 (156 Reviews) • 89 Followers',
            ),

            const SizedBox(height: 20),

            const Text(
              'Products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            GridView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              itemCount:
                  controller.farmProducts.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: .72,
              ),
              itemBuilder: (context, index) {
                final product =
                    controller.farmProducts[index];

                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.asset(
                          product.image,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Padding(
                        padding:
                            const EdgeInsets.all(8),
                        child: Text(
                          product.name,
                          maxLines: 1,
                          overflow:
                              TextOverflow.ellipsis,
                        ),
                      ),

                      Padding(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '\$${product.price.toStringAsFixed(2)}/${product.unit}',
                                style: const TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.addProduct(
                                  product,
                                );
                              },
                              icon: const Icon(
                                Icons.add_circle,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}