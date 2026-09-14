import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:phum_kasikor/controllers/auth/profile_controller.dart';
import 'package:phum_kasikor/color/color.dart';
=======
import 'package:phum_kasikor/view/Farmer/farmer_ui.dart';

import '../../color/color.dart';
import 'farmer_farm_profile.dart';

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
>>>>>>> 744fd6f7d54ceab51c903be45c36f5f884a57161

class FarmerProfileScreen extends StatelessWidget {
  const FarmerProfileScreen({super.key});

  @override
<<<<<<< HEAD
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Profile content will go here
            const Expanded(child: Center(child: Text('Farmer Profile'))),
            // Logout button
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: controller.isLoggingOut.value
                      ? null
                      : controller.showLogoutConfirmation,
                  icon: const Icon(Icons.logout),
                  label: Text(
                    controller.isLoggingOut.value ? 'Logging out...' : 'Logout',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade50,
                    foregroundColor: Colors.red.shade900,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
=======
  Widget build(BuildContext context) => FarmerPage(
    title: 'Profile',
    child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const CircleAvatar(
          radius: 38,
          backgroundColor: AppColors.primaryLight,
          child: Icon(Icons.person, size: 40, color: AppColors.primary),
        ),
        const SizedBox(height: 12),
        const Center(
          child: Text(
            'Sokha Organic Farm',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
        ),
        const SizedBox(height: 24),
        _ProfileMenuTile(
          icon: Icons.agriculture_outlined,
          label: 'Farm profile',
          onTap: () => Get.to(() => const FarmerFarmProfile()),
        ),
        _ProfileMenuTile(
          icon: Icons.settings_outlined,
          label: 'Account settings',
          onTap: () => Get.snackbar('Account settings', 'Coming soon.'),
        ),
      ],
    ),
  );
}
>>>>>>> 744fd6f7d54ceab51c903be45c36f5f884a57161
