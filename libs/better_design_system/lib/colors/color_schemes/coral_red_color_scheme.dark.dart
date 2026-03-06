import 'package:better_design_system/theme/theme.dart';
import 'package:flutter/services.dart';

import '../color_system.dart';
import '../color_palette.dart';

final coralRedDarkColorScheme = ColorSystem(
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
  primary: ColorPalette.coralRed400,
  primaryBold: ColorPalette.coralRed400,
  primaryVariant: ColorPalette.coralRed600,
  primaryVariantLow: ColorPalette.coralRed700,
  primaryContainer: ColorPalette.coralRed16Percent,
  primaryDisabled: ColorPalette.coralRed24Percent,
  onPrimary: ColorPalette.whiteMain,

  // Secondary colors
  secondary: ColorPalette.blue400,
  secondaryBold: ColorPalette.blue300,
  secondaryVariant: ColorPalette.blue500,
  secondaryVariantLow: ColorPalette.blue800,
  secondaryContainer: ColorPalette.blue16Percent,
  secondaryDisabled: ColorPalette.blue24Percent,
  onSecondary: ColorPalette.whiteMain,

  // Tertiary colors
  tertiary: ColorPalette.orange500,
  tertiaryBold: ColorPalette.orange400,
  tertiaryVariant: ColorPalette.orange700,
  tertiaryVariantLow: ColorPalette.orange800,
  tertiaryContainer: ColorPalette.orange16Percent,
  tertiaryDisabled: ColorPalette.orange24Percent,
  onTertiary: ColorPalette.whiteMain,

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
  betterTheme: BetterThemes.coralRed,
);
