import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// Color testing utility to verify contrast ratios and accessibility
class ColorTester {
  /// Calculate contrast ratio between two colors (WCAG standards)
  static double getContrastRatio(Color color1, Color color2) {
    final double luminance1 = _getLuminance(color1);
    final double luminance2 = _getLuminance(color2);
    
    final double lighter = luminance1 > luminance2 ? luminance1 : luminance2;
    final double darker = luminance1 > luminance2 ? luminance2 : luminance1;
    
    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Calculate relative luminance (0-1)
  static double _getLuminance(Color color) {
    final double r = _linearize((color.value >> 16 & 0xFF) / 255.0);
    final double g = _linearize((color.value >> 8 & 0xFF) / 255.0);
    final double b = _linearize((color.value & 0xFF) / 255.0);
    
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  static double _linearize(double value) {
    if (value <= 0.03928) {
      return value / 12.92;
    }
    return ((value + 0.055) / 1.055) * ((value + 0.055) / 1.055);
  }

  /// Check if contrast meets WCAG AA standard (4.5:1 for normal text, 3:1 for large text)
  static bool meetsWCAGAA(Color foreground, Color background, {bool isLargeText = false}) {
    final double ratio = getContrastRatio(foreground, background);
    return isLargeText ? ratio >= 3.0 : ratio >= 4.5;
  }

  /// Check if contrast meets WCAG AAA standard (7:1 for normal text, 4.5:1 for large text)
  static bool meetsWCAGAAA(Color foreground, Color background, {bool isLargeText = false}) {
    final double ratio = getContrastRatio(foreground, background);
    return isLargeText ? ratio >= 4.5 : ratio >= 7.0;
  }

  /// Get color accessibility report
  static Map<String, dynamic> getAccessibilityReport() {
    return {
      'textPrimary_on_backgroundDark': {
        'contrast': getContrastRatio(AppColors.textPrimary, AppColors.backgroundDark),
        'wcagAA': meetsWCAGAA(AppColors.textPrimary, AppColors.backgroundDark),
        'wcagAAA': meetsWCAGAAA(AppColors.textPrimary, AppColors.backgroundDark),
      },
      'textSecondary_on_backgroundDark': {
        'contrast': getContrastRatio(AppColors.textSecondary, AppColors.backgroundDark),
        'wcagAA': meetsWCAGAA(AppColors.textSecondary, AppColors.backgroundDark),
        'wcagAAA': meetsWCAGAAA(AppColors.textSecondary, AppColors.backgroundDark),
      },
      'primaryPurple_on_backgroundDark': {
        'contrast': getContrastRatio(AppColors.primaryPurple, AppColors.backgroundDark),
        'wcagAA': meetsWCAGAA(AppColors.primaryPurple, AppColors.backgroundDark),
        'wcagAAA': meetsWCAGAAA(AppColors.primaryPurple, AppColors.backgroundDark),
      },
      'primaryPink_on_backgroundDark': {
        'contrast': getContrastRatio(AppColors.primaryPink, AppColors.backgroundDark),
        'wcagAA': meetsWCAGAA(AppColors.primaryPink, AppColors.backgroundDark),
        'wcagAAA': meetsWCAGAAA(AppColors.primaryPink, AppColors.backgroundDark),
      },
    };
  }
}

/// Widget to display color test results
class ColorTestWidget extends StatelessWidget {
  const ColorTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final report = ColorTester.getAccessibilityReport();
    
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: const Text('Color Accessibility Test'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'WCAG Contrast Ratios',
            style: AppTextStyles.displaySmall,
          ),
          const SizedBox(height: 24),
          ...report.entries.map((entry) {
            return Card(
              color: AppColors.cardBackground,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key.replaceAll('_', ' ').toUpperCase(),
                      style: AppTextStyles.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Contrast Ratio: ${entry.value['contrast'].toStringAsFixed(2)}:1',
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          entry.value['wcagAA'] ? Icons.check_circle : Icons.cancel,
                          color: entry.value['wcagAA'] 
                              ? Colors.green 
                              : Colors.red,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'WCAG AA: ${entry.value['wcagAA'] ? "Pass" : "Fail"}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: entry.value['wcagAA'] 
                                ? Colors.green 
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          entry.value['wcagAAA'] ? Icons.check_circle : Icons.cancel,
                          color: entry.value['wcagAAA'] 
                              ? Colors.green 
                              : Colors.red,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'WCAG AAA: ${entry.value['wcagAAA'] ? "Pass" : "Fail"}',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: entry.value['wcagAAA'] 
                                ? Colors.green 
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

