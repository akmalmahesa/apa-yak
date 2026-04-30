import 'package:flutter/material.dart';

class AppColors {
  static const background   = Color(0xFFF5F0E8);
  static const surface      = Color(0xFFFFFFFF);
  static const primary      = Color(0xFF1A3D2B);
  static const accent       = Color(0xFFE9A84C);
  static const textPrimary  = Color(0xFF1A1A1A);
  static const textSecondary= Color(0xFF6B6B6B);
  static const textMuted    = Color(0xFF9E9E9E);
  static const progressBg   = Color(0xFFDDD8CE);
  static const tagBg        = Color(0xFFEEE9E0);
  static const currentReadingBg = Color(0xFFE8F4EE);
  static const borderColor  = Color(0xFFE0DAD0);
  static const starColor    = Color(0xFFF4C542);
}

class AppTextStyles {
  static const displayTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: 'Georgia',
  );

  static const sectionTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    fontFamily: 'Georgia',
  );

  static const bookTitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Georgia',
  );

  static const body = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
    height: 1.7,
    fontFamily: 'sans-serif',
  );

  static const caption = TextStyle(
    fontSize: 11,
    color: AppColors.textMuted,
    fontFamily: 'sans-serif',
  );

  static const label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.8,
    fontFamily: 'sans-serif',
  );
}

ThemeData buildAppTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Georgia',
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      surface: AppColors.surface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
    ),
  );
}