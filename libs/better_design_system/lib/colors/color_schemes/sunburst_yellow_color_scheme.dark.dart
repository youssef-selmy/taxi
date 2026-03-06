import 'package:better_design_system/theme/theme.dart';
import 'package:flutter/material.dart';

import '../color_system.dart';
import '../color_palette.dart';

final sunburstYellowDarkColorScheme = ColorSystem(
  // Surface colors
  surface: ColorPalette.neutral900,
  surfaceVariant: ColorPalette.neutral700,
  surfaceVariantLow: ColorPalette.neutral800,
  surfaceMuted: ColorPalette.neutral20Percent,
  surfaceContainer: ColorPalette.neutral16Percent,
  onSurface: ColorPalette.whiteMain,
  onSurfaceVariant: ColorPalette.neutral300,
  onSurfaceVariantLow: ColorPalette.neutral400,
  onSurfaceDisabled: ColorPalette.neutral600,
  onSurfaceMuted: ColorPalette.neutral32Percent,

  // Outline colors
  outline: ColorPalette.neutral600,
  outlineBold: ColorPalette.neutral200,
  outlineVariant: ColorPalette.neutral500,
  outlineDisabled: ColorPalette.neutral48Percent,

  // Primary colors
  primary: ColorPalette.cobalt500,
  primaryBold: ColorPalette.cobalt300,
  primaryVariant: ColorPalette.cobalt600,
  primaryVariantLow: ColorPalette.cobalt800,
  primaryContainer: ColorPalette.cobalt16Percent,
  primaryDisabled: ColorPalette.cobalt24Percent,
  onPrimary: ColorPalette.whiteMain,

  // Secondary colors
  secondary: ColorPalette.orange400,
  secondaryBold: ColorPalette.orange300,
  secondaryVariant: ColorPalette.orange500,
  secondaryVariantLow: ColorPalette.orange800,
  secondaryContainer: ColorPalette.orange16Percent,
  secondaryDisabled: ColorPalette.orange24Percent,
  onSecondary: ColorPalette.whiteMain,

  // Tertiary colors
  tertiary: ColorPalette.teal500,
  tertiaryBold: ColorPalette.teal400,
  tertiaryVariant: ColorPalette.teal700,
  tertiaryVariantLow: ColorPalette.teal800,
  tertiaryContainer: ColorPalette.teal16Percent,
  tertiaryDisabled: ColorPalette.teal24Percent,
  onTertiary: ColorPalette.blackMain,

  // Error colors
  error: ColorPalette.red400,
  errorBold: ColorPalette.red300,
  errorVariant: ColorPalette.red600,
  errorVariantLow: ColorPalette.red800,
  errorContainer: ColorPalette.red16Percent,
  errorDisabled: ColorPalette.red24Percent,
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
  success: ColorPalette.green500,
  successBold: ColorPalette.green400,
  successVariant: ColorPalette.green600,
  successVariantLow: ColorPalette.green800,
  successContainer: ColorPalette.green16Percent,
  successDisabled: ColorPalette.green24Percent,
  onSuccess: ColorPalette.whiteMain,

  // Info colors
  info: ColorPalette.blue400,
  infoBold: ColorPalette.blue300,
  infoVariant: ColorPalette.blue600,
  infoVariantLow: ColorPalette.blue800,
  infoContainer: ColorPalette.blue16Percent,
  infoDisabled: ColorPalette.blue24Percent,
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
  fixedDark: ColorPalette.neutral900,
  fixedLight: ColorPalette.whiteMain,

  brightness: Brightness.dark,
  betterTheme: BetterThemes.cobalt,
);
