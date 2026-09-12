import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/controllers/earnings_controller.dart';
import 'package:phum_kasikor/controllers/farmer_controller.dart';
import 'package:phum_kasikor/view/Farmer/farmer_earnings_screen.dart';
import 'package:phum_kasikor/view/Farmer/farmer_home_screen.dart';
import 'package:phum_kasikor/view/Farmer/farmer_my_farm.dart';
import 'package:phum_kasikor/view/Farmer/farmer_orders_screen.dart';
import 'package:phum_kasikor/view/Farmer/farmer_profile_screen.dart';

/// Root farmer screen with persistent navigation between all main sections.
class FarmerBottomNav extends StatefulWidget {
  const FarmerBottomNav({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<FarmerBottomNav> createState() => _FarmerBottomNavState();
}

class _FarmerBottomNavState extends State<FarmerBottomNav> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex.clamp(0, 4).toInt();
    if (!Get.isRegistered<FarmerController>()) {
      Get.put(FarmerController(), permanent: true);
    }
    if (!Get.isRegistered<EarningsController>()) {
      Get.put(EarningsController(), permanent: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const FarmerHomeScreen(),
      const FarmerMyFarmScreen(),
      const FarmerOrdersScreen(),
      EarningsScreen(),
      const FarmerProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.agriculture_outlined),
            selectedIcon: Icon(Icons.agriculture),
            label: 'Farm',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Earnings',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
