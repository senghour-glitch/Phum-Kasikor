import 'package:flutter/material.dart';
import 'package:phum_kasikor/model/customer/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final bool selected;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.category,
    this.selected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 78,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selected
              ? Colors.green.shade50
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? Colors.green
                : Colors.grey.shade200,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                category.icon,
                style: const TextStyle(fontSize: 22),
              ),
            ),

            const SizedBox(height: 6),

            Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: selected
                    ? Colors.green
                    : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}