import 'package:better_design_system/theme/theme.dart';
import 'package:flutter/services.dart';

import '../color_system.dart';
import '../color_palette.dart';

final hyperPinkDarkColorScheme = ColorSystem(
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
  primary: ColorPalette.hyperPink400,
  primaryBold: ColorPalette.hyperPink400,
  primaryVariant: ColorPalette.hyperPink600,
  primaryVariantLow: ColorPalette.hyperPink700,
  primaryContainer: ColorPalette.hyperPink16Percent,
  primaryDisabled: ColorPalette.hyperPink24Percent,
  onPrimary: ColorPalette.whiteMain,

  // Secondary colors
  secondary: ColorPalette.hyperBlue400,
  secondaryBold: ColorPalette.hyperBlue300,
  secondaryVariant: ColorPalette.hyperBlue500,
  secondaryVariantLow: ColorPalette.hyperBlue800,
  secondaryContainer: ColorPalette.hyperBlue16Percent,
  secondaryDisabled: ColorPalette.hyperBlue24Percent,
  onSecondary: ColorPalette.whiteMain,

  // Tertiary colors
  tertiary: ColorPalette.autumnOrange500,
  tertiaryBold: ColorPalette.autumnOrange400,
  tertiaryVariant: ColorPalette.autumnOrange700,
  tertiaryVariantLow: ColorPalette.autumnOrange800,
  tertiaryContainer: ColorPalette.autumnOrange16Percent,
  tertiaryDisabled: ColorPalette.autumnOrange24Percent,
  onTertiary: ColorPalette.whiteMain,

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
  betterTheme: BetterThemes.hyperPink,
);
