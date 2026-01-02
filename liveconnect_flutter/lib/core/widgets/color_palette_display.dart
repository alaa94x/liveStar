import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Widget to display and test the color palette
class ColorPaletteDisplay extends StatelessWidget {
  const ColorPaletteDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: const Text('Color Palette'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LiveConnect Color Palette',
              style: AppTextStyles.displaySmall,
            ),
            const SizedBox(height: 32),

            // Primary Colors
            _buildColorSection(
              'Primary Colors',
              [
                _ColorSwatch('Primary Purple', AppColors.primaryPurple),
                _ColorSwatch('Primary Pink', AppColors.primaryPink),
              ],
            ),

            const SizedBox(height: 24),

            // Background Colors
            _buildColorSection(
              'Background Colors',
              [
                _ColorSwatch('Background Dark', AppColors.backgroundDark),
                _ColorSwatch('Card Background', AppColors.cardBackground),
                _ColorSwatch('Surface Dark', AppColors.surfaceDark),
              ],
            ),

            const SizedBox(height: 24),

            // Text Colors
            _buildColorSection(
              'Text Colors',
              [
                _ColorSwatch('Text Primary', AppColors.textPrimary, textColor: AppColors.backgroundDark),
                _ColorSwatch('Text Secondary', AppColors.textSecondary, textColor: AppColors.backgroundDark),
                _ColorSwatch('Text Tertiary', AppColors.textTertiary, textColor: AppColors.backgroundDark),
              ],
            ),

            const SizedBox(height: 24),

            // UI Colors
            _buildColorSection(
              'UI Colors',
              [
                _ColorSwatch('Destructive', AppColors.destructive),
                _ColorSwatch('Live Red', AppColors.liveRed),
                _ColorSwatch('Coin Gold', AppColors.coinGold, textColor: AppColors.backgroundDark),
                _ColorSwatch('Input Background', AppColors.inputBackground, textColor: AppColors.backgroundDark),
              ],
            ),

            const SizedBox(height: 24),

            // Gradient Preview
            Text(
              'Gradient Preview',
              style: AppTextStyles.titleLarge,
            ),
            const SizedBox(height: 12),
            Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryPurple.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Primary Gradient',
                  style: AppTextStyles.buttonLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSection(String title, List<_ColorSwatch> colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.titleLarge,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: colors.map((color) => _buildColorCard(color)).toList(),
        ),
      ],
    );
  }

  Widget _buildColorCard(_ColorSwatch colorSwatch) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: colorSwatch.color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Text(
                colorSwatch.name,
                style: AppTextStyles.bodySmall.copyWith(
                  color: colorSwatch.textColor ?? AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  colorSwatch.name,
                  style: AppTextStyles.titleSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  _colorToHex(colorSwatch.color),
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }
}

class _ColorSwatch {
  final String name;
  final Color color;
  final Color? textColor;

  _ColorSwatch(this.name, this.color, {this.textColor});
}

