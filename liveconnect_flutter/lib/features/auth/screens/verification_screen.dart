import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: const Center(
        child: Text(
          'Verification Screen',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

