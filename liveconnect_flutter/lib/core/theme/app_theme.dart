import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_text_styles.dart';
import 'app_colors.dart';

class AppTheme {
  // Color Palette
  static const Color primaryPurple = Color(0xFFC700FF);
  static const Color primaryPink = Color(0xFFFF2D92);
  static const Color backgroundDark = Color(0xFF0D0D0F);
  static const Color cardBackground = Color(0xFF1A1A1F);
  static const Color surfaceDark = Color(0xFF1A1A1F);
  
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xB3FFFFFF); // 70% opacity
  static const Color textTertiary = Color(0x99FFFFFF); // 60% opacity
  
  static const Color borderColor = Color(0x1A000000); // 10% opacity black
  static const Color destructive = Color(0xFFD4183D);
  
  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryPurple, primaryPink],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x40000000), Colors.transparent, Color(0x99000000)],
  );

  // Light Theme (not primary, but available)
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryPurple,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Inter',
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
        displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.black),
      ),
    );
  }

  // Dark Theme (Primary)
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: primaryPurple,
        secondary: primaryPink,
        surface: cardBackground,
        error: destructive,
        onPrimary: textPrimary,
        onSecondary: textPrimary,
        onSurface: textPrimary,
        onError: textPrimary,
      ),
      // fontFamily: 'Inter', // Using system font for now
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.displayMedium,
        displaySmall: AppTextStyles.displaySmall,
        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
        headlineSmall: AppTextStyles.headlineSmall,
        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedium,
        titleSmall: AppTextStyles.titleSmall,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        hintStyle: AppTextStyles.inputHint,
        labelStyle: AppTextStyles.inputLabel,
        errorStyle: AppTextStyles.inputError,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: primaryPurple,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: destructive,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: destructive,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: cardBackground,
        selectedItemColor: primaryPink,
        unselectedItemColor: textTertiary,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
  
  // Text Styles
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );
  
  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );
  
  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );
  
  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textPrimary,
  );
  
  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textPrimary,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: textSecondary,
  );
}

