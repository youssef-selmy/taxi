import 'dart:ui';

import 'package:better_design_system/colors/color_system.dart';
import 'package:better_design_system/colors/color_palette.dart';
import 'package:better_design_system/theme/theme.dart';

final coralRedLightColorScheme = ColorSystem(
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
  primary: ColorPalette.coralRed500,
  primaryBold: ColorPalette.coralRed700,
  primaryVariant: ColorPalette.coralRed100,
  primaryVariantLow: ColorPalette.coralRed50,
  primaryContainer: ColorPalette.coralRed12Percent,
  primaryDisabled: ColorPalette.coralRed48Percent,
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
  tertiary: ColorPalette.violet600,
  tertiaryBold: ColorPalette.violet700,
  tertiaryVariant: ColorPalette.violet100,
  tertiaryVariantLow: ColorPalette.violet50,
  tertiaryContainer: ColorPalette.violet12Percent,
  tertiaryDisabled: ColorPalette.violet32Percent,
  onTertiary: ColorPalette.whiteMain,

  // Status: Error colors
  error: ColorPalette.hyperPink500,
  errorBold: ColorPalette.hyperPink700,
  errorVariant: ColorPalette.hyperPink100,
  errorVariantLow: ColorPalette.hyperPink50,
  errorContainer: ColorPalette.hyperPink12Percent,
  errorDisabled: ColorPalette.hyperPink48Percent,
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
  betterTheme: BetterThemes.coralRed,
);
