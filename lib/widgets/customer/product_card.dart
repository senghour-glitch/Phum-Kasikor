import 'package:flutter/material.dart';
import 'package:phum_kasikor/model/customer/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onAdd;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onAdd,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================
            // Product Image
            // =========================
            AspectRatio(
              aspectRatio: 1.2,
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      product.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),

            // =========================
            // Product Name
            // =========================
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 6, 4),
              child: Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),

            // =========================
            // Farm Name
            // =========================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                product.farmName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
            ),

            const SizedBox(height: 4),

            // =========================
            // Price + Add Button
            // =========================
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 5, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '\$${product.price.toStringAsFixed(2)}/${product.unit}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: onAdd,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.green,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),

            // =========================
            // Rating
            // =========================
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.orange,
                    size: 14,
                  ),
                  const SizedBox(width: 3),

                  Text(
                    product.rating.toString(),
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),

                  const SizedBox(width: 4),

                  Text(
                    '(${product.reviewCount})',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}