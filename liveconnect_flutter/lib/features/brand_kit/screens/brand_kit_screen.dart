import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class BrandKitScreen extends StatelessWidget {
  const BrandKitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: const Text('Brand Kit'),
      ),
      body: const Center(
        child: Text(
          'Brand Kit Screen',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

