import 'package:better_design_system/theme/theme.dart';
import 'package:flutter/services.dart';

import '../color_system.dart';
import '../color_palette.dart';

final noirDarkColorScheme = ColorSystem(
  // Surface colors
  surface: ColorPalette.blackMain,
  onSurface: ColorPalette.whiteMain,
  surfaceVariant: ColorPalette.stone800,
  surfaceVariantLow: ColorPalette.stone900,
  surfaceMuted: ColorPalette.stone20Percent,
  surfaceContainer: ColorPalette.stone16Percent,
  onSurfaceVariant: ColorPalette.stone300,
  onSurfaceVariantLow: ColorPalette.stone400,
  onSurfaceMuted: ColorPalette.white32Percent,
  onSurfaceDisabled: ColorPalette.stone600,

  // Outline colors
  outline: ColorPalette.stone700,
  outlineBold: ColorPalette.stone200,
  outlineVariant: ColorPalette.stone600,
  outlineDisabled: ColorPalette.stone16Percent,

  // Primary colors
  primary: ColorPalette.whiteMain,
  onPrimary: ColorPalette.blackMain,
  primaryBold: ColorPalette.stone400,
  primaryVariant: ColorPalette.stone600,
  primaryVariantLow: ColorPalette.stone700,
  primaryContainer: ColorPalette.white20Percent,
  primaryDisabled: ColorPalette.white48Percent,

  // Secondary colors
  secondary: ColorPalette.cobalt300,
  onSecondary: ColorPalette.whiteMain,
  secondaryBold: ColorPalette.cobalt400,
  secondaryVariant: ColorPalette.cobalt600,
  secondaryVariantLow: ColorPalette.cobalt700,
  secondaryContainer: ColorPalette.cobalt16Percent,
  secondaryDisabled: ColorPalette.cobalt24Percent,

  // Tertiary colors
  tertiary: ColorPalette.lime400,
  tertiaryBold: ColorPalette.lime300,
  tertiaryVariant: ColorPalette.lime600,
  tertiaryVariantLow: ColorPalette.lime800,
  tertiaryContainer: ColorPalette.lime20Percent,
  tertiaryDisabled: ColorPalette.lime24Percent,
  onTertiary: ColorPalette.blackMain,

  // Status colors - Error
  error: ColorPalette.red400,
  onError: ColorPalette.whiteMain,
  errorBold: ColorPalette.red300,
  errorVariant: ColorPalette.red600,
  errorVariantLow: ColorPalette.red800,
  errorContainer: ColorPalette.red16Percent,
  errorDisabled: ColorPalette.red24Percent,

  // Status colors - Info
  info: ColorPalette.blue400,
  onInfo: ColorPalette.whiteMain,
  infoBold: ColorPalette.blue300,
  infoVariant: ColorPalette.blue600,
  infoVariantLow: ColorPalette.blue800,
  infoContainer: ColorPalette.blue16Percent,
  infoDisabled: ColorPalette.blue24Percent,

  // Status colors - Success
  success: ColorPalette.green500,
  onSuccess: ColorPalette.whiteMain,
  successBold: ColorPalette.green300,
  successVariant: ColorPalette.green600,
  successVariantLow: ColorPalette.green800,
  successContainer: ColorPalette.green16Percent,
  successDisabled: ColorPalette.green24Percent,

  // Status colors - Warning
  warning: ColorPalette.orange400,
  onWarning: ColorPalette.whiteMain,
  warningBold: ColorPalette.orange300,
  warningVariant: ColorPalette.orange500,
  warningVariantLow: ColorPalette.orange600,
  warningContainer: ColorPalette.orange16Percent,
  warningDisabled: ColorPalette.orange24Percent,

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
  fixedDark: ColorPalette.stone900,
  fixedLight: ColorPalette.whiteMain,

  brightness: Brightness.dark,
  betterTheme: BetterThemes.noir,
);
