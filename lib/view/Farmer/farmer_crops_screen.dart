import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/farmer_controller.dart';
import '../../widgets/farmer/crop_card.dart';
import 'farmer_add_crop_screen.dart';
import 'farmer_crop_detail_screen.dart';
import 'farmer_ui.dart';

class FarmerCropsScreen extends StatelessWidget {
  const FarmerCropsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final farmer = Get.find<FarmerController>();
    return FarmerPage(
      title: 'Crops Monitor',
      action: IconButton(
        tooltip: 'Add crop',
        onPressed: () => Get.to(() => const FarmerAddCropScreen()),
        icon: const Icon(Icons.add),
      ),
      child: Obx(
        () => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Track every crop from planting to harvest.',
              style: TextStyle(color: Color(0xFF718074)),
            ),
            const SizedBox(height: 18),
            ...farmer.crops.map(
              (crop) => CropCard(
                crop: crop,
                onTap: () =>
                    Get.to(() => FarmerCropDetailScreen(cropId: crop.id)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
