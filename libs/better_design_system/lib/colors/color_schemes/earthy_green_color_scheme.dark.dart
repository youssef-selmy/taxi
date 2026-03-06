import 'package:better_design_system/theme/theme.dart';
import 'package:flutter/material.dart';

import '../color_system.dart';
import '../color_palette.dart';

final earthyGreenDarkColorScheme = ColorSystem(
  // Surface colors
  surface: ColorPalette.sageGray900,
  surfaceVariant: ColorPalette.sageGray700,
  surfaceVariantLow: ColorPalette.sageGray800,
  surfaceMuted: ColorPalette.sageGray20Percent,
  surfaceContainer: ColorPalette.sageGray16Percent,

  onSurface: ColorPalette.whiteMain,
  onSurfaceVariant: ColorPalette.sageGray300,
  onSurfaceVariantLow: ColorPalette.sageGray400,
  onSurfaceDisabled: ColorPalette.sageGray24Percent,
  onSurfaceMuted: ColorPalette.sageGray32Percent,

  // Outline colors
  outline: ColorPalette.sageGray800,
  outlineBold: ColorPalette.sageGray200,
  outlineVariant: ColorPalette.sageGray600,
  outlineDisabled: ColorPalette.sageGray48Percent,

  // Primary colors
  primary: ColorPalette.earthyGreen400,
  primaryBold: ColorPalette.earthyGreen300,
  primaryVariant: ColorPalette.earthyGreen600,
  primaryVariantLow: ColorPalette.earthyGreen800,
  primaryContainer: ColorPalette.earthyGreen16Percent,
  primaryDisabled: ColorPalette.earthyGreen32Percent,
  onPrimary: ColorPalette.whiteMain,

  // Secondary colors
  secondary: ColorPalette.lime400,
  secondaryBold: ColorPalette.lime300,
  secondaryVariant: ColorPalette.lime600,
  secondaryVariantLow: ColorPalette.lime800,
  secondaryContainer: ColorPalette.lime12Percent,
  secondaryDisabled: ColorPalette.lime24Percent,
  onSecondary: ColorPalette.blackMain,

  // Tertiary colors
  tertiary: ColorPalette.autumnOrange400,
  tertiaryBold: ColorPalette.autumnOrange300,
  tertiaryVariant: ColorPalette.autumnOrange700,
  tertiaryVariantLow: ColorPalette.autumnOrange800,
  tertiaryContainer: ColorPalette.autumnOrange16Percent,
  tertiaryDisabled: ColorPalette.autumnOrange24Percent,
  onTertiary: ColorPalette.blackMain,

  // Error colors
  error: ColorPalette.coralFlame400,
  errorBold: ColorPalette.coralFlame300,
  errorVariant: ColorPalette.coralFlame600,
  errorVariantLow: ColorPalette.coralFlame800,
  errorContainer: ColorPalette.coralFlame16Percent,
  errorDisabled: ColorPalette.coralFlame24Percent,
  onError: ColorPalette.whiteMain,

  // Warning colors
  warning: ColorPalette.orange400,
  warningBold: ColorPalette.orange300,
  warningVariant: ColorPalette.orange500,
  warningVariantLow: ColorPalette.orange600,
  warningContainer: ColorPalette.orange16Percent,
  warningDisabled: ColorPalette.orange24Percent,
  onWarning: ColorPalette.whiteMain,

  // Success colors
  success: ColorPalette.springGreen400,
  successBold: ColorPalette.springGreen300,
  successVariant: ColorPalette.springGreen600,
  successVariantLow: ColorPalette.springGreen800,
  successContainer: ColorPalette.springGreen16Percent,
  successDisabled: ColorPalette.springGreen24Percent,
  onSuccess: ColorPalette.blackMain,

  // Info colors
  info: ColorPalette.oceanBlue400,
  infoBold: ColorPalette.oceanBlue300,
  infoVariant: ColorPalette.oceanBlue600,
  infoVariantLow: ColorPalette.oceanBlue800,
  infoContainer: ColorPalette.oceanBlue16Percent,
  infoDisabled: ColorPalette.oceanBlue24Percent,
  onInfo: ColorPalette.whiteMain,

  // Insight colors
  insight: ColorPalette.purple400,
  insightBold: ColorPalette.purple300,
  insightVariant: ColorPalette.purple600,
  insightVariantLow: ColorPalette.purple800,
  insightContainer: ColorPalette.purple16Percent,
  insightDisabled: ColorPalette.purple24Percent,
  onInsight: ColorPalette.whiteMain,

  // Misc
  shadow: ColorPalette.neutral900.withAlpha(0),

  // Fixed colors
  fixedDark: ColorPalette.sageGray900,
  fixedLight: ColorPalette.whiteMain,

  brightness: Brightness.dark,
  betterTheme: BetterThemes.earthyGreen,
);
