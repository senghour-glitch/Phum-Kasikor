import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/auth/auth_header.dart';
import '../../controllers/auth/role_selection_controller.dart';

class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RoleSelectionController());
    return AuthPage(
      showBack: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          const AuthTitle(title: 'Choose Your Role', subtitle: 'How will you use Phum Kasikor?'),
          const SizedBox(height: 28),
          Obx(() => _RoleCard(
            selected: controller.selectedRole.value == 'farmer',
            icon: Icons.agriculture_rounded,
            title: "I'm a Farmer",
            description: 'Sell fresh produce directly to customers.',
            onTap: () => controller.selectRole('farmer'),
          )),
          const SizedBox(height: 14),
          Obx(() => _RoleCard(
            selected: controller.selectedRole.value == 'customer',
            icon: Icons.shopping_basket_rounded,
            title: "I'm a Customer",
            description: 'Discover and buy fresh local produce.',
            onTap: () => controller.selectRole('customer'),
          )),
          Obx(() => controller.errorMessage.value != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(controller.errorMessage.value!, style: const TextStyle(color: Colors.red, fontSize: 12)),
                )
              : const SizedBox.shrink()),
          const Spacer(),
          Obx(() => FarmButton(
            label: controller.isLoading.value ? 'Saving...' : 'Continue',
            onPressed: controller.isLoading.value ? null : controller.confirmRole,
          )),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.selected,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });
  final bool selected;
  final IconData icon;
  final String title, description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFFE9F6EA) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: selected ? kFarmGreen : const Color(0xFFE0E8E0), width: selected ? 1.5 : 1),
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: selected ? kFarmGreen : const Color(0xFFF1F5F1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: selected ? Colors.white : kFarmGreen),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: kFarmInk)),
            const SizedBox(height: 3),
            Text(description, style: const TextStyle(fontSize: 12, color: kFarmMuted)),
          ]),
        ),
        if (selected) const Icon(Icons.check_circle, color: kFarmGreen),
      ]),
    ),
  );
}
