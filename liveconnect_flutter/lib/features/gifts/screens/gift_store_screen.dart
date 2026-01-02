import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class GiftStoreScreen extends StatelessWidget {
  const GiftStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: const Text('Gift Store'),
      ),
      body: const Center(
        child: Text(
          'Gift Store Screen',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

