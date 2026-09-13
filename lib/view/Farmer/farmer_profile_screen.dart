import 'package:flutter/material.dart';

class FarmerProfileScreen extends StatelessWidget {
  const FarmerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
<<<<<<< HEAD
}
=======

  void _comingSoon(String feature) => Get.snackbar(
    feature,
    'This feature will be available soon.',
    snackPosition: SnackPosition.BOTTOM,
  );
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();
  @override
  Widget build(BuildContext context) => const Column(
    children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 38,
            backgroundColor: Color(0xFFE0EBD9),
            child: Icon(
              Icons.person_rounded,
              size: 52,
              color: AppColors.primary,
            ),
          ),
          Positioned(
            right: -1,
            bottom: -1,
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.edit, size: 12, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 13),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Sokha Vann',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          SizedBox(width: 5),
          Icon(Icons.verified, color: AppColors.success, size: 17),
        ],
      ),
      SizedBox(height: 3),
      Text(
        'Certified Organic Farmer',
        style: TextStyle(color: Color(0xFF607D8B)),
      ),
    ],
  );
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({required this.productCount});
  final int productCount;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 11),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: AppColors.border),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        _Stat(value: '$productCount', label: 'Products'),
        _Divider(),
        _Stat(value: '156', label: 'Orders'),
        _Divider(),
        _Stat(value: '4.8', label: 'Rating'),
      ],
    ),
  );
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) => const SizedBox(
    height: 36,
    child: VerticalDivider(width: 1, color: Color(0xFFE8EDEE)),
  );
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF607D8B)),
        ),
      ],
    ),
  );
}

class _ProfileMenuTile extends StatelessWidget {
  const _ProfileMenuTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 47,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20, color: const Color(0xFF587585)),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFF91AAB5)),
            ],
          ),
        ),
      ),
    ),
  );
}
>>>>>>> 29f5c6a (Update customer features)
