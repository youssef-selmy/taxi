import 'dart:ui';

import 'package:better_design_system/theme/theme.dart';

import '../color_system.dart';
import '../color_palette.dart';

final autumnOrangeLightColorScheme = ColorSystem(
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
  primary: ColorPalette.autumnOrange500,
  primaryBold: ColorPalette.autumnOrange700,
  primaryVariant: ColorPalette.autumnOrange100,
  primaryVariantLow: ColorPalette.autumnOrange50,
  primaryContainer: ColorPalette.autumnOrange12Percent,
  primaryDisabled: ColorPalette.autumnOrange48Percent,
  onPrimary: ColorPalette.whiteMain,

  // Secondary colors
  secondary: ColorPalette.lime500,
  secondaryBold: ColorPalette.lime700,
  secondaryVariant: ColorPalette.lime100,
  secondaryVariantLow: ColorPalette.lime50,
  secondaryContainer: ColorPalette.lime12Percent,
  secondaryDisabled: ColorPalette.lime32Percent,
  onSecondary: ColorPalette.whiteMain,

  // Tertiary colors
  tertiary: ColorPalette.sky500,
  tertiaryBold: ColorPalette.sky700,
  tertiaryVariant: ColorPalette.sky100,
  tertiaryVariantLow: ColorPalette.sky50,
  tertiaryContainer: ColorPalette.sky12Percent,
  tertiaryDisabled: ColorPalette.sky32Percent,
  onTertiary: ColorPalette.blackMain,

  // Status: Error colors
  error: ColorPalette.coralFlame500,
  errorBold: ColorPalette.coralFlame700,
  errorVariant: ColorPalette.coralFlame100,
  errorVariantLow: ColorPalette.coralFlame50,
  errorContainer: ColorPalette.coralFlame12Percent,
  errorDisabled: ColorPalette.coralFlame32Percent,
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
  success: ColorPalette.springGreen500,
  successBold: ColorPalette.springGreen700,
  successVariant: ColorPalette.springGreen100,
  successVariantLow: ColorPalette.springGreen50,
  successContainer: ColorPalette.springGreen8Percent,
  successDisabled: ColorPalette.springGreen32Percent,
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
  betterTheme: BetterThemes.autumnOrange,
);
