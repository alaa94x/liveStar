import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class InterestScreen extends StatelessWidget {
  const InterestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: const Center(
        child: Text(
          'Interest Screen',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

