import 'package:flutter/material.dart';
import 'package:phum_kasikor/color/color.dart';
import 'package:phum_kasikor/model/crop_model.dart';

class CropCard extends StatelessWidget {
  const CropCard({super.key, required this.crop, required this.onTap});
  final CropModel crop;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Card(child: ListTile(onTap: onTap, leading: const CircleAvatar(backgroundColor: AppColors.primaryLight, child: Icon(Icons.eco_outlined, color: AppColors.primary)), title: Text(crop.name, style: const TextStyle(fontWeight: FontWeight.w700)), subtitle: Text(crop.status), trailing: const Icon(Icons.chevron_right)));
}
