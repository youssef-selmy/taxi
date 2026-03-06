import 'dart:ui';

import 'package:better_design_system/theme/theme.dart';

import '../color_system.dart';
import '../color_palette.dart';

final noirLightColorScheme = ColorSystem(
  // Base surface colors
  surface: ColorPalette.whiteMain,
  surfaceMuted: ColorPalette.stone8Percent,
  surfaceVariant: ColorPalette.stone100,
  surfaceVariantLow: ColorPalette.stone50,

  // On surface colors
  onSurface: ColorPalette.blackMain,
  surfaceContainer: ColorPalette.stone12Percent,
  onSurfaceDisabled: ColorPalette.stone400,
  onSurfaceMuted: ColorPalette.black32Percent,
  onSurfaceVariant: ColorPalette.stone600,
  onSurfaceVariantLow: ColorPalette.stone500,

  // Outline/border colors
  outline: ColorPalette.stone200,
  outlineDisabled: ColorPalette.stone16Percent,
  outlineBold: ColorPalette.stone700,
  outlineVariant: ColorPalette.stone300,

  // Primary colors
  primary: ColorPalette.blackMain,
  primaryBold: ColorPalette.stone700,
  primaryContainer: ColorPalette.black12Percent,
  primaryDisabled: ColorPalette.black48Percent,
  onPrimary: ColorPalette.whiteMain,
  primaryVariant: ColorPalette.stone200,
  primaryVariantLow: ColorPalette.stone100,

  // Secondary colors
  secondary: ColorPalette.cobalt500,
  secondaryBold: ColorPalette.cobalt700,
  secondaryContainer: ColorPalette.cobalt12Percent,
  secondaryDisabled: ColorPalette.cobalt48Percent,
  onSecondary: ColorPalette.whiteMain,
  secondaryVariant: ColorPalette.cobalt100,
  secondaryVariantLow: ColorPalette.cobalt50,

  // Tertiary colors
  tertiary: ColorPalette.lime500,
  tertiaryBold: ColorPalette.lime700,
  tertiaryVariant: ColorPalette.lime100,
  tertiaryVariantLow: ColorPalette.lime50,
  tertiaryContainer: ColorPalette.lime12Percent,
  tertiaryDisabled: ColorPalette.lime32Percent,
  onTertiary: ColorPalette.whiteMain,

  // Status colors: Error
  error: ColorPalette.red500,
  errorBold: ColorPalette.red700,
  errorContainer: ColorPalette.red50,
  errorDisabled: ColorPalette.red12Percent,
  onError: ColorPalette.whiteMain,
  errorVariant: ColorPalette.red100,
  errorVariantLow: ColorPalette.red50,

  // Status colors: Success
  success: ColorPalette.green500,
  successBold: ColorPalette.green700,
  successContainer: ColorPalette.green8Percent,
  successDisabled: ColorPalette.green32Percent,
  onSuccess: ColorPalette.whiteMain,
  successVariant: ColorPalette.green100,
  successVariantLow: ColorPalette.green50,

  // Status colors: Warning
  warning: ColorPalette.orange500,
  warningBold: ColorPalette.orange700,
  warningContainer: ColorPalette.orange50,
  warningDisabled: ColorPalette.orange32Percent,
  onWarning: ColorPalette.whiteMain,
  warningVariant: ColorPalette.orange200,
  warningVariantLow: ColorPalette.orange50,

  // Status colors: Info
  info: ColorPalette.blue500,
  infoBold: ColorPalette.blue600,
  infoContainer: ColorPalette.blue12Percent,
  infoDisabled: ColorPalette.blue48Percent,
  onInfo: ColorPalette.whiteMain,
  infoVariant: ColorPalette.blue100,
  infoVariantLow: ColorPalette.blue50,

  // Insight colors
  insight: ColorPalette.purple500,
  insightBold: ColorPalette.purple700,
  insightVariant: ColorPalette.purple100,
  insightVariantLow: ColorPalette.purple50,
  insightContainer: ColorPalette.purple8Percent,
  insightDisabled: ColorPalette.purple32Percent,
  onInsight: ColorPalette.whiteMain,

  // Utility
  shadow: ColorPalette.stone16Percent,

  // Fixed colors
  fixedDark: ColorPalette.stone900,
  fixedLight: ColorPalette.whiteMain,

  brightness: Brightness.light,
  betterTheme: BetterThemes.noir,
);
