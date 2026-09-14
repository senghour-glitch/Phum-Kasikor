import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerBottomNav extends StatelessWidget {
  final int currentIndex;

  const CustomerBottomNav({
    super.key,
    this.currentIndex = 0,
  });

  void _onTap(int index) {
    switch (index) {
      case 0:
        Get.offAllNamed('/customer-home');
        break;

      case 1:
        Get.offAllNamed('/customer-explore');
        break;

      case 2:
        Get.offAllNamed('/customer-orders');
        break;

      case 3:
        Get.offAllNamed('/customer-cart');
        break;

      case 4:
        Get.offAllNamed('/customer-profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: _onTap,
      type: BottomNavigationBarType.fixed,

      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          activeIcon: Icon(Icons.explore),
          label: 'Explore',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.receipt_long_outlined),
          activeIcon: Icon(Icons.receipt_long),
          label: 'Orders',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          activeIcon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}