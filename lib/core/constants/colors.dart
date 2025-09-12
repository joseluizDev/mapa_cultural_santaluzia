import 'package:flutter/material.dart';

class AppColors {
  static const Color culturalRed = Color(0xFFc63122);
  static const Color culturalBlue = Color(0xFF115a91);
  static const Color brazilianGreen = Color(0xFF447832);
  static const Color cream = Color(0xFFf3e2c6);

  static const Color gray50 = Color(0xFFf9fafb);
  static const Color gray100 = Color(0xFFf3f4f6);
  static const Color gray500 = Color(0xFF6b7280);
  static const Color gray900 = Color(0xFF111827);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [culturalRed, culturalBlue],
    stops: [0.0, 1.0],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [culturalBlue, brazilianGreen],
    stops: [0.0, 1.0],
  );

  static const LinearGradient warmGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [cream, Color(0xFFfceeea)],
    stops: [0.0, 1.0],
  );

  static const Color white = Color(0xFFFFFFFF);
  static const Color primaryBlack = gray900;
  static const Color darkGray = Color(0xFF424242);
  static const Color mediumGray = gray500;
  static const Color lightGray = gray100;
  static const Color lightBackground = gray50;

  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = culturalBlue;

  static const Color primaryText = primaryBlack;
  static const Color secondaryText = mediumGray;
  static const Color whiteText = white;

  static const Color cardBackground = white;
  static const Color cardGlassmorphismBackground = Color(0xE6f5e3c7);

  static const Color cardShadow = Color(0x1A000000);
  static const Color cardBorder = lightGray;

  AppColors._();
}

class AppShadows {
  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: AppColors.cardShadow,
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: AppColors.cardShadow,
      offset: Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];

  AppShadows._();
}
