import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryPurple = Color(0xFFC700FF);
  static const Color primaryPink = Color(0xFFFF2D92);
  
  // Background Colors
  static const Color backgroundDark = Color(0xFF0D0D0F);
  static const Color cardBackground = Color(0xFF1A1A1F);
  static const Color surfaceDark = Color(0xFF1A1A1F);
  
  // Text Colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xB3FFFFFF); // 70% opacity
  static const Color textTertiary = Color(0x99FFFFFF); // 60% opacity
  static const Color textMuted = Color(0x717182);
  
  // UI Colors
  static const Color borderColor = Color(0x1A000000); // 10% opacity black
  static const Color destructive = Color(0xFFD4183D);
  static const Color accent = Color(0xFFE9EBEF);
  static const Color muted = Color(0xFFECECF0);
  static const Color inputBackground = Color(0xFFF3F3F5);
  
  // Live Badge
  static const Color liveRed = Color(0xFFDC2626);
  
  // Coin Color
  static const Color coinGold = Color(0xFFFFD700);
  
  // Overlay Colors
  static const Color overlayLight = Color(0x40000000); // 25% opacity
  static const Color overlayMedium = Color(0x66000000); // 40% opacity
  static const Color overlayDark = Color(0x99000000); // 60% opacity
  
  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryPurple, primaryPink],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [overlayLight, Colors.transparent, overlayDark],
  );
  
  static const LinearGradient bottomOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, overlayDark],
  );
}

