import 'package:flutter/material.dart';
import '../../widgets/auth/auth_header.dart';
import '../Farmer/farmer_home_screen.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      showBack: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const AuthTitle(
            title: 'Set Your Location',
            subtitle: 'This helps customers find fresh produce near them.',
          ),
          const SizedBox(height: 26),
          Container(
            height: 190,
            decoration: BoxDecoration(
              color: const Color(0xFFE0F3D5),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFCBE2C0)),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.map_rounded,
                  size: 115,
                  color: Color(0xFF90C897),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.location_on_rounded,
                    color: Colors.red,
                    size: 31,
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Text(
                      'Phnom Penh',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const FarmTextField(label: 'Province / City', hint: 'Phnom Penh'),
          const FarmTextField(label: 'District', hint: 'Chamkarmon'),
          const FarmTextField(label: 'Commune / Sangkat', hint: 'Tonle Bassac'),
          const Spacer(),
          FarmButton(
            label: 'Set Location',
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const FarmerHomeScreen()),
              (_) => false,
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}
