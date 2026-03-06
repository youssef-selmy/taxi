import 'dart:ui';

import 'package:better_design_system/theme/theme.dart';

import '../color_system.dart';
import '../color_palette.dart';

final earthyGreenLightColorScheme = ColorSystem(
  // Surface related colors
  surface: ColorPalette.whiteMain,
  surfaceMuted: ColorPalette.sageGray8Percent,
  surfaceVariant: ColorPalette.sageGray100,
  surfaceVariantLow: ColorPalette.sageGray50,
  surfaceContainer: ColorPalette.sageGray12Percent,

  onSurface: ColorPalette.sageGray900,
  onSurfaceVariant: ColorPalette.sageGray700,
  onSurfaceVariantLow: ColorPalette.sageGray500,
  onSurfaceMuted: ColorPalette.sageGray32Percent,
  onSurfaceDisabled: ColorPalette.sageGray24Percent,

  // Outline related colors
  outline: ColorPalette.sageGray100,
  outlineVariant: ColorPalette.sageGray200,
  outlineBold: ColorPalette.sageGray700,
  outlineDisabled: ColorPalette.sageGray16Percent,

  // Shadow
  shadow: ColorPalette.sageGray16Percent,

  // Primary colors
  primary: ColorPalette.earthyGreen500,
  primaryBold: ColorPalette.earthyGreen700,
  primaryVariant: ColorPalette.earthyGreen100,
  primaryVariantLow: ColorPalette.earthyGreen50,
  primaryContainer: ColorPalette.earthyGreen12Percent,
  primaryDisabled: ColorPalette.earthyGreen48Percent,
  onPrimary: ColorPalette.whiteMain,

  // Secondary colors
  secondary: ColorPalette.lime500,
  secondaryBold: ColorPalette.lime700,
  secondaryVariant: ColorPalette.lime100,
  secondaryVariantLow: ColorPalette.lime50,
  secondaryContainer: ColorPalette.lime8Percent,
  secondaryDisabled: ColorPalette.lime32Percent,
  onSecondary: ColorPalette.blackMain,

  // Tertiary colors
  tertiary: ColorPalette.autumnOrange500,
  tertiaryBold: ColorPalette.autumnOrange700,
  tertiaryVariant: ColorPalette.autumnOrange100,
  tertiaryVariantLow: ColorPalette.autumnOrange50,
  tertiaryContainer: ColorPalette.autumnOrange12Percent,
  tertiaryDisabled: ColorPalette.autumnOrange32Percent,
  onTertiary: ColorPalette.whiteMain,

  // Status: Error colors
  error: ColorPalette.coralFlame500,
  errorBold: ColorPalette.coralFlame700,
  errorVariant: ColorPalette.coralFlame100,
  errorVariantLow: ColorPalette.coralFlame50,
  errorContainer: ColorPalette.coralFlame12Percent,
  errorDisabled: ColorPalette.coralFlame32Percent,
  onError: ColorPalette.whiteMain,

  // Status: Info colors
  info: ColorPalette.oceanBlue500,
  infoBold: ColorPalette.oceanBlue700,
  infoVariant: ColorPalette.oceanBlue100,
  infoVariantLow: ColorPalette.oceanBlue50,
  infoContainer: ColorPalette.oceanBlue12Percent,
  infoDisabled: ColorPalette.oceanBlue32Percent,
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
  successDisabled: ColorPalette.springGreen48Percent,
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
  fixedDark: ColorPalette.sageGray900,
  fixedLight: ColorPalette.whiteMain,

  brightness: Brightness.light,
  betterTheme: BetterThemes.earthyGreen,
);
