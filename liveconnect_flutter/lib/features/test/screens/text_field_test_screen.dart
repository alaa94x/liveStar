import 'package:flutter/material.dart';
import '../../../core/widgets/enhanced_text_field.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Test screen for text fields with various states and configurations
class TextFieldTestScreen extends StatefulWidget {
  const TextFieldTestScreen({super.key});

  @override
  State<TextFieldTestScreen> createState() => _TextFieldTestScreenState();
}

class _TextFieldTestScreenState extends State<TextFieldTestScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _multilineController = TextEditingController();
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _multilineController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: const Text('Text Field Test'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enhanced Text Fields',
              style: AppTextStyles.displaySmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Test various input field states and configurations',
              style: AppTextStyles.bodySecondary,
            ),
            const SizedBox(height: 32),

            // Email Field
            Text(
              'Email Field',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 12),
            EnhancedTextField(
              controller: _emailController,
              labelText: 'Email Address',
              hintText: 'Enter your email',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              helperText: 'We\'ll never share your email',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),

            const SizedBox(height: 32),

            // Password Field
            Text(
              'Password Field',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 12),
            EnhancedTextField(
              controller: _passwordController,
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: Icons.lock_outlined,
              obscureText: true,
              helperText: 'Must be at least 8 characters',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                if (value.length < 8) {
                  return 'Password must be at least 8 characters';
                }
                return null;
              },
            ),

            const SizedBox(height: 32),

            // Phone Field
            Text(
              'Phone Number Field',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 12),
            EnhancedTextField(
              controller: _phoneController,
              labelText: 'Phone Number',
              hintText: '+1 (555) 123-4567',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 32),

            // Multiline Field
            Text(
              'Multiline Field',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 12),
            EnhancedTextField(
              controller: _multilineController,
              labelText: 'Description',
              hintText: 'Enter your description here...',
              prefixIcon: Icons.description_outlined,
              maxLines: 4,
              maxLength: 200,
            ),

            const SizedBox(height: 32),

            // Search Field
            Text(
              'Search Field',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 12),
            EnhancedTextField(
              controller: _searchController,
              labelText: 'Search',
              hintText: 'Search for streams, users...',
              prefixIcon: Icons.search,
              textInputAction: TextInputAction.search,
            ),

            const SizedBox(height: 32),

            // Disabled Field
            Text(
              'Disabled Field',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 12),
            EnhancedTextField(
              labelText: 'Disabled Input',
              hintText: 'This field is disabled',
              prefixIcon: Icons.lock_outline,
              enabled: false,
            ),

            const SizedBox(height: 32),

            // Field with Error
            Text(
              'Field with Error',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: 12),
            EnhancedTextField(
              labelText: 'Email',
              hintText: 'Enter email',
              prefixIcon: Icons.email_outlined,
              errorText: 'This email is already registered',
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

