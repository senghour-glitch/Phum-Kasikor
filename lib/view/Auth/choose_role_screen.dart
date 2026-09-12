import 'package:flutter/material.dart';
import '../../widgets/auth/auth_header.dart';
import 'profile_setup_screen.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});
  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  bool isFarmer = true;
  @override
  Widget build(BuildContext context) => AuthPage(
    showBack: true,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const AuthTitle(
          title: 'Choose Your Role',
          subtitle: 'How will you use Phum Kasikor?',
        ),
        const SizedBox(height: 28),
        _RoleCard(
          selected: isFarmer,
          icon: Icons.agriculture_rounded,
          title: "I'm a Farmer",
          description: 'Sell fresh produce directly to customers.',
          onTap: () => setState(() => isFarmer = true),
        ),
        const SizedBox(height: 14),
        _RoleCard(
          selected: !isFarmer,
          icon: Icons.shopping_basket_rounded,
          title: "I'm a Customer",
          description: 'Discover and buy fresh local produce.',
          onTap: () => setState(() => isFarmer = false),
        ),
        const Spacer(),
        FarmButton(
          label: 'Continue',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfileSetupScreen()),
          ),
        ),
        const SizedBox(height: 28),
      ],
    ),
  );
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
        border: Border.all(
          color: selected ? kFarmGreen : const Color(0xFFE0E8E0),
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: kFarmInk,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: kFarmMuted),
                ),
              ],
            ),
          ),
          if (selected) const Icon(Icons.check_circle, color: kFarmGreen),
        ],
      ),
    ),
  );
}
