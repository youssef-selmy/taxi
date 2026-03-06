import 'package:better_design_system/colors/color_system.dart';
import 'package:better_design_system/colors/color_palette.dart';
import 'package:better_design_system/theme/theme.dart';
import 'package:flutter/services.dart';

final cobaltLightColorScheme = ColorSystem(
  // Surface related colors
  surface: ColorPalette.whiteMain,
  surfaceMuted: ColorPalette.neutral8Percent,
  surfaceVariant: ColorPalette.neutral100,
  surfaceVariantLow: ColorPalette.neutral50,
  surfaceContainer: ColorPalette.neutral12Percent,
  onSurface: ColorPalette.neutral900,
  onSurfaceVariant: ColorPalette.neutral600,
  onSurfaceVariantLow: ColorPalette.neutral500,
  onSurfaceMuted: ColorPalette.neutral32Percent,
  onSurfaceDisabled: ColorPalette.neutral400,

  // Outline related colors
  outline: ColorPalette.neutral200,
  outlineVariant: ColorPalette.neutral300,
  outlineBold: ColorPalette.neutral700,
  outlineDisabled: ColorPalette.neutral16Percent,

  // Shadow
  shadow: ColorPalette.neutral16Percent,

  // Primary colors
  primary: ColorPalette.cobalt500,
  primaryBold: ColorPalette.cobalt800,
  primaryVariant: ColorPalette.cobalt100,
  primaryVariantLow: ColorPalette.cobalt50,
  primaryContainer: ColorPalette.cobalt12Percent,
  primaryDisabled: ColorPalette.cobalt48Percent,
  onPrimary: ColorPalette.whiteMain,

  // Secondary colors
  secondary: ColorPalette.amber500,
  secondaryBold: ColorPalette.amber700,
  secondaryVariant: ColorPalette.amber100,
  secondaryVariantLow: ColorPalette.amber50,
  secondaryContainer: ColorPalette.amber12Percent,
  secondaryDisabled: ColorPalette.amber32Percent,
  onSecondary: ColorPalette.whiteMain,

  // Tertiary colors
  tertiary: ColorPalette.teal600,
  tertiaryBold: ColorPalette.teal700,
  tertiaryVariant: ColorPalette.teal100,
  tertiaryVariantLow: ColorPalette.teal50,
  tertiaryContainer: ColorPalette.teal12Percent,
  tertiaryDisabled: ColorPalette.teal32Percent,
  onTertiary: ColorPalette.whiteMain,

  // Status: Error colors
  error: ColorPalette.red500,
  errorBold: ColorPalette.red700,
  errorVariant: ColorPalette.red100,
  errorVariantLow: ColorPalette.red50,
  errorContainer: ColorPalette.red12Percent,
  errorDisabled: ColorPalette.red12Percent,
  onError: ColorPalette.whiteMain,

  // Status: Info colors
  info: ColorPalette.blue500,
  infoBold: ColorPalette.blue600,
  infoVariant: ColorPalette.blue100,
  infoVariantLow: ColorPalette.blue50,
  infoContainer: ColorPalette.blue12Percent,
  infoDisabled: ColorPalette.blue48Percent,
  onInfo: ColorPalette.whiteMain,

  // Status: Warning colors
  warning: ColorPalette.orange500,
  warningBold: ColorPalette.orange700,
  warningVariant: ColorPalette.orange100,
  warningVariantLow: ColorPalette.orange50,
  warningContainer: ColorPalette.orange12Percent,
  warningDisabled: ColorPalette.orange32Percent,
  onWarning: ColorPalette.whiteMain,

  // Status: Success colors
  success: ColorPalette.green500,
  successBold: ColorPalette.green700,
  successVariant: ColorPalette.green100,
  successVariantLow: ColorPalette.green50,
  successContainer: ColorPalette.green8Percent,
  successDisabled: ColorPalette.green32Percent,
  onSuccess: ColorPalette.whiteMain,

  // Insight colors
  insight: ColorPalette.purple500,
  insightBold: ColorPalette.purple700,
  insightVariant: ColorPalette.purple100,
  insightVariantLow: ColorPalette.purple50,
  insightContainer: ColorPalette.purple8Percent,
  insightDisabled: ColorPalette.purple32Percent,
  onInsight: ColorPalette.whiteMain,

  // Fixed colors
  fixedDark: ColorPalette.neutral900,
  fixedLight: ColorPalette.whiteMain,

  brightness: Brightness.light,
  betterTheme: BetterThemes.cobalt,
);
