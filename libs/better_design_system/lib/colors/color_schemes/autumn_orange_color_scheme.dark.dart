import 'package:better_design_system/theme/theme.dart';
import 'package:flutter/material.dart';

import '../color_system.dart';
import '../color_palette.dart';

final autumnOrangeDarkColorScheme = ColorSystem(
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
  outline: ColorPalette.neutral700,
  outlineBold: ColorPalette.neutral200,
  outlineVariant: ColorPalette.neutral600,
  outlineDisabled: ColorPalette.neutral48Percent,

  // Primary colors
  primary: ColorPalette.autumnOrange400,
  primaryBold: ColorPalette.autumnOrange300,
  primaryVariant: ColorPalette.autumnOrange700,
  primaryVariantLow: ColorPalette.autumnOrange800,
  primaryContainer: ColorPalette.autumnOrange16Percent,
  primaryDisabled: ColorPalette.autumnOrange24Percent,
  onPrimary: ColorPalette.whiteMain,

  // Secondary colors
  secondary: ColorPalette.lime500,
  secondaryBold: ColorPalette.lime300,
  secondaryVariant: ColorPalette.lime500,
  secondaryVariantLow: ColorPalette.lime800,
  secondaryContainer: ColorPalette.lime16Percent,
  secondaryDisabled: ColorPalette.lime24Percent,
  onSecondary: ColorPalette.whiteMain,

  // Tertiary colors
  tertiary: ColorPalette.sky500,
  tertiaryBold: ColorPalette.sky400,
  tertiaryVariant: ColorPalette.sky700,
  tertiaryVariantLow: ColorPalette.sky800,
  tertiaryContainer: ColorPalette.sky16Percent,
  tertiaryDisabled: ColorPalette.sky24Percent,
  onTertiary: ColorPalette.blackMain,

  // Error colors
  error: ColorPalette.coralRed400,
  errorBold: ColorPalette.coralRed300,
  errorVariant: ColorPalette.coralRed600,
  errorVariantLow: ColorPalette.coralRed800,
  errorContainer: ColorPalette.coralRed16Percent,
  errorDisabled: ColorPalette.coralRed24Percent,
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
  success: ColorPalette.springGreen500,
  successBold: ColorPalette.springGreen400,
  successVariant: ColorPalette.springGreen600,
  successVariantLow: ColorPalette.springGreen800,
  successContainer: ColorPalette.springGreen16Percent,
  successDisabled: ColorPalette.springGreen24Percent,
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
  betterTheme: BetterThemes.autumnOrange,
);
