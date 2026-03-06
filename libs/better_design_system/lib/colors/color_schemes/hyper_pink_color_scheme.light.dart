import 'dart:ui';

import 'package:better_design_system/colors/color_system.dart';
import 'package:better_design_system/colors/color_palette.dart';
import 'package:better_design_system/theme/theme.dart';

final hyperPinkLightColorScheme = ColorSystem(
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
  primary: ColorPalette.hyperPink500,
  primaryBold: ColorPalette.hyperPink700,
  primaryVariant: ColorPalette.hyperPink100,
  primaryVariantLow: ColorPalette.hyperPink50,
  primaryContainer: ColorPalette.hyperPink12Percent,
  primaryDisabled: ColorPalette.hyperPink48Percent,
  onPrimary: ColorPalette.whiteMain,

  // Secondary colors
  secondary: ColorPalette.hyperBlue500,
  secondaryBold: ColorPalette.hyperBlue700,
  secondaryVariant: ColorPalette.hyperBlue100,
  secondaryVariantLow: ColorPalette.hyperBlue50,
  secondaryContainer: ColorPalette.hyperBlue12Percent,
  secondaryDisabled: ColorPalette.hyperBlue48Percent,
  onSecondary: ColorPalette.whiteMain,

  // Tertiary colors
  tertiary: ColorPalette.autumnOrange600,
  tertiaryBold: ColorPalette.autumnOrange700,
  tertiaryVariant: ColorPalette.autumnOrange100,
  tertiaryVariantLow: ColorPalette.autumnOrange50,
  tertiaryContainer: ColorPalette.autumnOrange12Percent,
  tertiaryDisabled: ColorPalette.autumnOrange48Percent,
  onTertiary: ColorPalette.whiteMain,

  // Status: Error colors
  error: ColorPalette.coralRed500,
  errorBold: ColorPalette.coralRed700,
  errorVariant: ColorPalette.coralRed100,
  errorVariantLow: ColorPalette.coralRed50,
  errorContainer: ColorPalette.coralRed12Percent,
  errorDisabled: ColorPalette.coralRed48Percent,
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
  fixedDark: ColorPalette.neutral900,
  fixedLight: ColorPalette.whiteMain,

  brightness: Brightness.light,
  betterTheme: BetterThemes.coralRed,
);
