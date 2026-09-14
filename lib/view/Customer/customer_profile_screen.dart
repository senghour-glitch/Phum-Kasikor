import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/color/color.dart';
import 'package:phum_kasikor/core/routes/app_routes.dart';
import 'package:phum_kasikor/controllers/customer/profile_controller.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
          children: [
            const _ProfileCard(),
            const SizedBox(height: 12),
            const _Statistics(),
            const SizedBox(height: 12),
            _MenuTile(
              icon: Icons.inventory_2_outlined,
              title: 'My Orders',
              trailing: const _CountBadge(value: '12'),
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.customerOrderTracking),
            ),
            _MenuTile(
              icon: Icons.favorite_border_rounded,
              title: 'Favorite Farms',
              onTap: () => _showComingSoon(context, 'Favorite farms'),
            ),
            _MenuTile(
              icon: Icons.star_border_rounded,
              title: 'My Reviews',
              onTap: () => _showComingSoon(context, 'My reviews'),
            ),
            _MenuTile(
              icon: Icons.location_on_outlined,
              title: 'Delivery Addresses',
              onTap: () => _showComingSoon(context, 'Delivery addresses'),
            ),
            _MenuTile(
              icon: Icons.credit_card_outlined,
              title: 'Payment Methods',
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.customerPayment),
            ),
            _MenuTile(
              icon: Icons.auto_awesome_rounded,
              iconColor: AppColors.primary,
              title: 'AI Chat Assistant ',
              titleColor: AppColors.primary,
              onTap: () => _showComingSoon(context, 'AI Chat Assistant'),
            ),
            _MenuTile(
              icon: Icons.notifications_none_rounded,
              title: 'Notification Settings',
              onTap: () => _showComingSoon(context, 'Notification settings'),
            ),
            _MenuTile(
              icon: Icons.language_rounded,
              title: 'Language (ភាសាខ្មែរ)',
              onTap: () => _showComingSoon(context, 'Language settings'),
            ),
            _MenuTile(
              icon: Icons.help_outline_rounded,
              title: 'Help & Support',
              onTap: () => _showComingSoon(context, 'Help & support'),
            ),
            _MenuTile(
              icon: Icons.info_outline_rounded,
              title: 'About PHUM KASIKOR',
              onTap: () => _showComingSoon(context, 'About PHUM KASIKOR'),
            ),
            const SizedBox(height: 2),
            OutlinedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false,
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(46),
                foregroundColor: AppColors.error,
                side: const BorderSide(color: Color(0xFFFF7777)),
                backgroundColor: const Color(0xFFFFF1F1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: const Text(
                'Log Out',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$feature will be available soon.')));
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(17),
        boxShadow: const [
          BoxShadow(
            color: Color(0x120B2810),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              const CircleAvatar(
                radius: 27,
                backgroundColor: Color(0xFFD9C4AE),
                child: Icon(
                  Icons.person_rounded,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              Positioned(
                right: -1,
                bottom: -1,
                child: Container(
                  width: 17,
                  height: 17,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.fromBorderSide(
                      BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: const Icon(
                    Icons.camera_alt_rounded,
                    size: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Channa Sok',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 3),
          const Text(
            'Member since July 2024',
            style: TextStyle(fontSize: 9, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 4),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_rounded,
                size: 12,
                color: AppColors.success,
              ),
              SizedBox(width: 3),
              Text(
                'Phnom Penh, Cambodia',
                style: TextStyle(
                  fontSize: 9,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Statistics extends StatelessWidget {
  const _Statistics();

  @override
  Widget build(BuildContext context) => const Row(
    children: [
      Expanded(
        child: _Stat(value: '12', label: 'Orders'),
      ),
      SizedBox(width: 7),
      Expanded(
        child: _Stat(value: '8', label: 'Favorites'),
      ),
      SizedBox(width: 7),
      Expanded(
        child: _Stat(value: '5', label: 'Reviews'),
      ),
    ],
  );
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    height: 56,
    decoration: BoxDecoration(
      color: AppColors.surface,
      border: Border.all(color: AppColors.border),
      borderRadius: BorderRadius.circular(9),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 8, color: AppColors.textSecondary),
        ),
      ],
    ),
  );
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
    this.iconColor = const Color(0xFF547785),
    this.titleColor = AppColors.textPrimary,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color iconColor;
  final Color titleColor;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 7),
    child: Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, size: 18, color: iconColor),
              const SizedBox(width: 13),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                  ),
                ),
              ),
              if (trailing != null) ...[trailing!, const SizedBox(width: 7)],
              const Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: Color(0xFF547785),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.value});
  final String value;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
    decoration: BoxDecoration(
      color: AppColors.primaryLight,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      value,
      style: const TextStyle(
        fontSize: 9,
        color: AppColors.primary,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}
