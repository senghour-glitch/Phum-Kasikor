import 'package:flutter/material.dart';

class FarmerProductPreviewScreen extends StatelessWidget {
  const FarmerProductPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Product')),
      body: const Center(child: Text('Product Preview')),
    );
  }
}