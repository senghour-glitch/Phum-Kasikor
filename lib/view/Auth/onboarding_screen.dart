import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phum_kasikor/view/Auth/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  final _pages = const [
    ('Fresh From the Farm', 'Connecting local Cambodian farmers directly with households. Enjoy premium, organic, and certified fresh produce while supporting local communities.'),
    ('Support Local Farmers', 'Every purchase goes straight to the farmer who grew it.'),
    ('Delivered To Your Door', 'Fast, reliable delivery from farm to table.'),
  ];

  void _finish() => Get.off(() => const WelcomeScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(onPressed: _finish, child: const Text('Skip')),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.agriculture, size: 120, color: Color(0xFF2E7D32)),
                      const SizedBox(height: 32),
                      Text(_pages[i].$1, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      const SizedBox(height: 12),
                      Text(_pages[i].$2, style: const TextStyle(color: Colors.grey), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (i) => Container(
                margin: const EdgeInsets.all(4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i == _page ? const Color(0xFF2E7D32) : Colors.grey.shade300,
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_page == _pages.length - 1) {
                      _finish();
                    } else {
                      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                    }
                  },
                  child: Text(_page == _pages.length - 1 ? 'Get Started' : 'Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}