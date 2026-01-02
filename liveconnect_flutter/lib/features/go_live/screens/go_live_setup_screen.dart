import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class GoLiveSetupScreen extends StatelessWidget {
  const GoLiveSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: const Center(
        child: Text(
          'Go Live Setup Screen',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

