import 'package:flutter/material.dart';
import '../../widgets/auth/auth_header.dart';
import 'location_screen.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      showBack: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const AuthTitle(
              title: 'Profile Setup',
              subtitle: 'Tell us a little more to get started.',
            ),
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 39,
                    backgroundColor: Color(0xFFE8F5E9),
                    child: Icon(
                      Icons.person_rounded,
                      size: 44,
                      color: kFarmGreen,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: kFarmGreen,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const FarmTextField(label: 'Full name', hint: 'Sok Dara'),
            const FarmTextField(
              label: 'Shop / farm name',
              hint: 'Dara Fresh Farm',
            ),
            const FarmTextField(
              label: 'Bio (optional)',
              hint: 'Share something about your farm',
            ),
            const FarmTextField(
              label: 'Address',
              hint: 'Village, commune, district',
            ),
            const FarmTextField(
              label: 'Phone number',
              hint: '+855 12 345 678',
              keyboardType: TextInputType.phone,
            ),
            FarmButton(
              label: 'Save & Continue',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LocationScreen()),
              ),
            ),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }
}
