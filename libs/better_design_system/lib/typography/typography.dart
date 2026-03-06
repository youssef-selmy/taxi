import 'package:flutter/material.dart';
import 'package:better_assets/assets.dart';

typedef BetterTextStyle = AppTextStyle;

abstract class AppTextStyle {
  static const String _fontPackage = BetterFonts.package;

  static TextTheme get textTheme => const TextTheme(
    displayLarge: TextStyle(
      fontFamily: BetterFonts.generalSans,
      fontSize: 49,
      height: 1.31,
      fontWeight: FontWeight.w500,
      // letterSpacing: 0.49,
      package: _fontPackage,
    ),
    displayMedium: TextStyle(
      fontFamily: BetterFonts.generalSans,
      fontSize: 39,
      height: 1.23,
      fontWeight: FontWeight.w500,
      // letterSpacing: 0.39,
      package: _fontPackage,
    ),
    displaySmall: TextStyle(
      fontFamily: BetterFonts.generalSans,
      fontSize: 34,
      height: 1.18,
      fontWeight: FontWeight.w500,
      // letterSpacing: 0.34,
      package: _fontPackage,
    ),
    headlineLarge: TextStyle(
      fontFamily: BetterFonts.generalSans,
      fontSize: 31,
      height: 1.29,
      fontWeight: FontWeight.w600,
      // letterSpacing: 0.31,
      package: _fontPackage,
    ),
    headlineMedium: TextStyle(
      fontFamily: BetterFonts.generalSans,
      fontSize: 27,
      height: 1.48,
      fontWeight: FontWeight.w500,
      // letterSpacing: 0.27,
      package: _fontPackage,
    ),
    headlineSmall: TextStyle(
      fontFamily: BetterFonts.generalSans,
      fontSize: 24,
      height: 1.33,
      fontWeight: FontWeight.w600,
      // letterSpacing: 0.24,
      package: _fontPackage,
    ),
    titleLarge: TextStyle(
      fontFamily: BetterFonts.generalSans,
      fontSize: 21,
      height: 1.52,
      fontWeight: FontWeight.w600,
      // letterSpacing: 0.21,
      package: _fontPackage,
    ),
    titleMedium: TextStyle(
      fontFamily: BetterFonts.generalSans,
      fontSize: 18,
      height: 1.33,
      fontWeight: FontWeight.w600,
      // letterSpacing: 0.18,
      package: _fontPackage,
    ),
    titleSmall: TextStyle(
      fontFamily: BetterFonts.generalSans,
      fontSize: 16,
      height: 1.5,
      fontWeight: FontWeight.w600,
      // letterSpacing: 0.16,
      package: _fontPackage,
    ),
    bodyLarge: TextStyle(
      fontFamily: BetterFonts.inter,
      fontSize: 16,
      height: 1.5,
      fontWeight: FontWeight.w400,
      // letterSpacing: -0.16,
      package: _fontPackage,
    ),
    bodyMedium: TextStyle(
      fontFamily: BetterFonts.inter,
      fontSize: 14,
      height: 1.43,
      fontWeight: FontWeight.w400,
      // letterSpacing: -0.14,
      package: _fontPackage,
    ),
    bodySmall: TextStyle(
      fontFamily: BetterFonts.inter,
      fontSize: 12,
      height: 1.33,
      fontWeight: FontWeight.w400,
      // letterSpacing: -0.12,
      package: _fontPackage,
    ),
    labelLarge: TextStyle(
      fontFamily: BetterFonts.inter,
      fontSize: 14,
      height: 1.43,
      fontWeight: FontWeight.w500,
      // letterSpacing: -0.14,
      package: _fontPackage,
    ),
    labelMedium: TextStyle(
      fontFamily: BetterFonts.inter,
      fontSize: 12,
      height: 1.33,
      fontWeight: FontWeight.w500,
      // letterSpacing: -0.12,
      package: _fontPackage,
    ),
    labelSmall: TextStyle(
      fontFamily: BetterFonts.inter,
      fontSize: 10,
      height: 1.2,
      fontWeight: FontWeight.w500,
      // letterSpacing: -0.1,
      package: _fontPackage,
    ),
  );
}
