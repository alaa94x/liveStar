import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/theme/app_colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: const Center(
        child: Text(
          'Sign Up Screen',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
    );
  }
}

