import 'package:flutter/material.dart';
import '../../widgets/auth/auth_header.dart';
import 'welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingState();
}

class _OnboardingState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int currentPage = 0;

  @override

   void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  
   @override

  Widget build(BuildContext context) {
    return AuthPage(
      child: Column(
        children: [
          const Spacer(),
          const AuthIllustration(
            icon: Icons.eco_rounded,
            color: Color(0xFFFFF2C5),
          ),
          const SizedBox(height: 36),
          const AuthTitle(
            center: true,
            title: 'Fresh From the Farm',
            subtitle:
                'Connect with local farmers and discover fresh produce grown near you.',
          ),
          const SizedBox(height: 22),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.remove, color: kFarmGreen),
              Icon(Icons.remove, color: Color(0xFFCBD7CC)),
              Icon(Icons.remove, color: Color(0xFFCBD7CC)),
            ],
          ),
          const Spacer(),
          FarmButton(
            label: 'Next',
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const WelcomeScreen()),
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
   final List<Map<String, String>> pages = [
    {
      'image': 'assets/images/farm_onboarding.png',
      'khmerTitle': 'ស្រស់ពីកសិដ្ឋានមកដល់អ្នក',
      'title': 'Fresh From the Farm',
      'description':
          'Connecting local Cambodian farmers directly with households. Enjoy premium, organic, and fresh produce while supporting local communities.',
    },
    {
      'image': 'assets/images/farm_onboarding.png',
      'khmerTitle': 'គាំទ្រកសិករមូលដ្ឋាន',
      'title': 'Support Local Farmers',
      'description':
          'Buy fresh products directly from local farmers and help strengthen Cambodian farming communities.',
    },
    {
      'image': 'assets/images/farm_onboarding.png',
      'khmerTitle': 'ទិញបានងាយស្រួល',
      'title': 'Shop Fresh & Easy',
      'description':
          'Discover fresh farm products, order easily, and enjoy a simple shopping experience.',
    },
  ];
}
