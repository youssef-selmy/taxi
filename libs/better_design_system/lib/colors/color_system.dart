import 'package:better_design_system/theme/theme.dart';
import 'package:flutter/material.dart';

class ColorSystem extends ThemeExtension<ColorSystem> {
  final Color primary;
  final Color primaryBold;
  final Color primaryDisabled;
  final Color primaryVariant;
  final Color primaryVariantLow;
  final Color onPrimary;
  final Color primaryContainer;

  final Color secondary;
  final Color secondaryBold;
  final Color secondaryDisabled;
  final Color secondaryVariant;
  final Color secondaryVariantLow;
  final Color onSecondary;
  final Color secondaryContainer;

  final Color tertiary;
  final Color tertiaryBold;
  final Color tertiaryDisabled;
  final Color tertiaryVariant;
  final Color tertiaryVariantLow;
  final Color onTertiary;
  final Color tertiaryContainer;

  final Color surface;
  final Color surfaceMuted;
  final Color surfaceVariant;
  final Color surfaceVariantLow;
  final Color surfaceContainer;

  final Color onSurface;
  final Color onSurfaceVariant;
  final Color onSurfaceVariantLow;
  final Color onSurfaceMuted;
  final Color onSurfaceDisabled;

  final Color outline;
  final Color outlineBold;
  final Color outlineVariant;
  final Color outlineDisabled;

  final Color success;
  final Color successBold;
  final Color successDisabled;
  final Color successVariant;
  final Color successVariantLow;
  final Color onSuccess;
  final Color successContainer;

  final Color warning;
  final Color warningBold;
  final Color warningDisabled;
  final Color warningVariant;
  final Color warningVariantLow;
  final Color onWarning;
  final Color warningContainer;

  final Color error;
  final Color errorBold;
  final Color errorDisabled;
  final Color errorVariant;
  final Color errorVariantLow;
  final Color onError;
  final Color errorContainer;

  final Color info;
  final Color infoBold;
  final Color infoDisabled;
  final Color infoVariant;
  final Color infoVariantLow;
  final Color onInfo;
  final Color infoContainer;

  final Color insight;
  final Color insightBold;
  final Color insightDisabled;
  final Color insightVariant;
  final Color insightVariantLow;
  final Color onInsight;
  final Color insightContainer;

  final Color shadow;

  final Color fixedLight;
  final Color fixedDark;

  final Brightness brightness;

  final BetterThemes betterTheme;

  ColorSystem({
    required this.primary,
    required this.primaryBold,
    required this.primaryDisabled,
    required this.primaryVariant,
    required this.primaryVariantLow,
    required this.onPrimary,
    required this.primaryContainer,
    required this.secondary,
    required this.secondaryBold,
    required this.secondaryDisabled,
    required this.secondaryVariant,
    required this.secondaryVariantLow,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.tertiary,
    required this.tertiaryBold,
    required this.tertiaryDisabled,
    required this.tertiaryVariant,
    required this.tertiaryVariantLow,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.surface,
    required this.surfaceMuted,
    required this.surfaceVariant,
    required this.surfaceVariantLow,
    required this.surfaceContainer,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.onSurfaceVariantLow,
    required this.onSurfaceMuted,
    required this.onSurfaceDisabled,
    required this.outline,
    required this.outlineBold,
    required this.outlineVariant,
    required this.outlineDisabled,
    required this.success,
    required this.successBold,
    required this.successDisabled,
    required this.successVariant,
    required this.successVariantLow,
    required this.onSuccess,
    required this.successContainer,
    required this.warning,
    required this.warningBold,
    required this.warningDisabled,
    required this.warningVariant,
    required this.warningVariantLow,
    required this.onWarning,
    required this.warningContainer,
    required this.error,
    required this.errorBold,
    required this.errorDisabled,
    required this.errorVariant,
    required this.errorVariantLow,
    required this.onError,
    required this.errorContainer,
    required this.info,
    required this.infoBold,
    required this.infoDisabled,
    required this.infoVariant,
    required this.infoVariantLow,
    required this.onInfo,
    required this.infoContainer,
    required this.insight,
    required this.insightBold,
    required this.insightDisabled,
    required this.insightVariant,
    required this.insightVariantLow,
    required this.onInsight,
    required this.insightContainer,
    required this.shadow,
    required this.fixedLight,
    required this.fixedDark,
    required this.brightness,
    required this.betterTheme,
  });

  @override
  ThemeExtension<ColorSystem> copyWith() => ColorSystem(
    primary: primary,
    primaryBold: primaryBold,
    primaryDisabled: primaryDisabled,
    primaryVariant: primaryVariant,
    primaryVariantLow: primaryVariantLow,
    onPrimary: onPrimary,
    primaryContainer: primaryContainer,
    secondary: secondary,
    secondaryBold: secondaryBold,
    secondaryDisabled: secondaryDisabled,
    secondaryVariant: secondaryVariant,
    secondaryVariantLow: secondaryVariantLow,
    onSecondary: onSecondary,
    secondaryContainer: secondaryContainer,
    tertiary: tertiary,
    tertiaryBold: tertiaryBold,
    tertiaryDisabled: tertiaryDisabled,
    tertiaryVariant: tertiaryVariant,
    tertiaryVariantLow: tertiaryVariantLow,
    onTertiary: onTertiary,
    tertiaryContainer: tertiaryContainer,
    surface: surface,
    surfaceMuted: surfaceMuted,
    surfaceVariant: surfaceVariant,
    surfaceVariantLow: surfaceVariantLow,
    surfaceContainer: surfaceContainer,
    onSurface: onSurface,
    onSurfaceVariant: onSurfaceVariant,
    onSurfaceVariantLow: onSurfaceVariantLow,
    onSurfaceMuted: onSurfaceMuted,
    onSurfaceDisabled: onSurfaceDisabled,
    outline: outline,
    outlineBold: outlineBold,
    outlineVariant: outlineVariant,
    outlineDisabled: outlineDisabled,
    success: success,
    successBold: successBold,
    successDisabled: successDisabled,
    successVariant: successVariant,
    successVariantLow: successVariantLow,
    onSuccess: onSuccess,
    successContainer: successContainer,
    warning: warning,
    warningBold: warningBold,
    warningDisabled: warningDisabled,
    warningVariant: warningVariant,
    warningVariantLow: warningVariantLow,
    onWarning: onWarning,
    warningContainer: warningContainer,
    error: error,
    errorBold: errorBold,
    errorDisabled: errorDisabled,
    errorVariant: errorVariant,
    errorVariantLow: errorVariantLow,
    onError: onError,
    errorContainer: errorContainer,
    info: info,
    infoBold: infoBold,
    infoDisabled: infoDisabled,
    infoVariant: infoVariant,
    infoVariantLow: infoVariantLow,
    onInfo: onInfo,
    infoContainer: infoContainer,
    insight: insight,
    insightBold: insightBold,
    insightDisabled: insightDisabled,
    insightVariant: insightVariant,
    insightVariantLow: insightVariantLow,
    onInsight: onInsight,
    insightContainer: insightContainer,
    shadow: shadow,
    fixedLight: fixedLight,
    fixedDark: fixedDark,
    brightness: brightness,
    betterTheme: betterTheme,
  );

  @override
  ThemeExtension<ColorSystem> lerp(
    covariant ThemeExtension<ColorSystem>? other,
    double t,
  ) {
    if (other is! ColorSystem) {
      return this;
    }
    return ColorSystem(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryBold: Color.lerp(primaryBold, other.primaryBold, t)!,
      primaryDisabled: Color.lerp(primaryDisabled, other.primaryDisabled, t)!,
      primaryVariant: Color.lerp(primaryVariant, other.primaryVariant, t)!,
      primaryVariantLow: Color.lerp(
        primaryVariantLow,
        other.primaryVariantLow,
        t,
      )!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryContainer: Color.lerp(
        primaryContainer,
        other.primaryContainer,
        t,
      )!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      secondaryBold: Color.lerp(secondaryBold, other.secondaryBold, t)!,
      secondaryDisabled: Color.lerp(
        secondaryDisabled,
        other.secondaryDisabled,
        t,
      )!,
      secondaryVariant: Color.lerp(
        secondaryVariant,
        other.secondaryVariant,
        t,
      )!,
      secondaryVariantLow: Color.lerp(
        secondaryVariantLow,
        other.secondaryVariantLow,
        t,
      )!,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t)!,
      secondaryContainer: Color.lerp(
        secondaryContainer,
        other.secondaryContainer,
        t,
      )!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
      tertiaryBold: Color.lerp(tertiaryBold, other.tertiaryBold, t)!,
      tertiaryDisabled: Color.lerp(
        tertiaryDisabled,
        other.tertiaryDisabled,
        t,
      )!,
      tertiaryVariant: Color.lerp(tertiaryVariant, other.tertiaryVariant, t)!,
      tertiaryVariantLow: Color.lerp(
        tertiaryVariantLow,
        other.tertiaryVariantLow,
        t,
      )!,
      onTertiary: Color.lerp(onTertiary, other.onTertiary, t)!,
      tertiaryContainer: Color.lerp(
        tertiaryContainer,
        other.tertiaryContainer,
        t,
      )!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceMuted: Color.lerp(surfaceMuted, other.surfaceMuted, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      surfaceVariantLow: Color.lerp(
        surfaceVariantLow,
        other.surfaceVariantLow,
        t,
      )!,
      surfaceContainer: Color.lerp(
        surfaceContainer,
        other.surfaceContainer,
        t,
      )!,
      onSurface: Color.lerp(onSurface, other.onSurface, t)!,
      onSurfaceVariant: Color.lerp(
        onSurfaceVariant,
        other.onSurfaceVariant,
        t,
      )!,
      onSurfaceVariantLow: Color.lerp(
        onSurfaceVariantLow,
        other.onSurfaceVariantLow,
        t,
      )!,
      onSurfaceMuted: Color.lerp(onSurfaceMuted, other.onSurfaceMuted, t)!,
      onSurfaceDisabled: Color.lerp(
        onSurfaceDisabled,
        other.onSurfaceDisabled,
        t,
      )!,
      outline: Color.lerp(outline, other.outline, t)!,
      outlineBold: Color.lerp(outlineBold, other.outlineBold, t)!,
      outlineVariant: Color.lerp(outlineVariant, other.outlineVariant, t)!,
      outlineDisabled: Color.lerp(outlineDisabled, other.outlineDisabled, t)!,
      success: Color.lerp(success, other.success, t)!,
      successBold: Color.lerp(successBold, other.successBold, t)!,
      successDisabled: Color.lerp(successDisabled, other.successDisabled, t)!,
      successVariant: Color.lerp(successVariant, other.successVariant, t)!,
      successVariantLow: Color.lerp(
        successVariantLow,
        other.successVariantLow,
        t,
      )!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      successContainer: Color.lerp(
        successContainer,
        other.successContainer,
        t,
      )!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningBold: Color.lerp(warningBold, other.warningBold, t)!,
      warningDisabled: Color.lerp(warningDisabled, other.warningDisabled, t)!,
      warningVariant: Color.lerp(warningVariant, other.warningVariant, t)!,
      warningVariantLow: Color.lerp(
        warningVariantLow,
        other.warningVariantLow,
        t,
      )!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      warningContainer: Color.lerp(
        warningContainer,
        other.warningContainer,
        t,
      )!,
      error: Color.lerp(error, other.error, t)!,
      errorBold: Color.lerp(errorBold, other.errorBold, t)!,
      errorDisabled: Color.lerp(errorDisabled, other.errorDisabled, t)!,
      errorVariant: Color.lerp(errorVariant, other.errorVariant, t)!,
      errorVariantLow: Color.lerp(errorVariantLow, other.errorVariantLow, t)!,
      onError: Color.lerp(onError, other.onError, t)!,
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t)!,
      info: Color.lerp(info, other.info, t)!,
      infoBold: Color.lerp(infoBold, other.infoBold, t)!,
      infoDisabled: Color.lerp(infoDisabled, other.infoDisabled, t)!,
      infoVariant: Color.lerp(infoVariant, other.infoVariant, t)!,
      infoVariantLow: Color.lerp(infoVariantLow, other.infoVariantLow, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t)!,
      insight: Color.lerp(insight, other.insight, t)!,
      insightBold: Color.lerp(insightBold, other.insightBold, t)!,
      insightDisabled: Color.lerp(insightDisabled, other.insightDisabled, t)!,
      insightVariant: Color.lerp(insightVariant, other.insightVariant, t)!,
      insightVariantLow: Color.lerp(
        insightVariantLow,
        other.insightVariantLow,
        t,
      )!,
      onInsight: Color.lerp(onInsight, other.onInsight, t)!,
      insightContainer: Color.lerp(
        insightContainer,
        other.insightContainer,
        t,
      )!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      fixedLight: Color.lerp(fixedLight, other.fixedLight, t)!,
      fixedDark: Color.lerp(fixedDark, other.fixedDark, t)!,
      brightness: t < 0.5 ? brightness : other.brightness,
      betterTheme: t < 0.5 ? betterTheme : other.betterTheme,
    );
  }

  /// Returns a fully transparent color for overlays and backgrounds.
  ///
  /// This is the theme-independent alternative to `Colors.transparent`.
  /// Use this instead of `Colors.transparent` to maintain theme consistency.
  ///
  /// Example:
  /// ```dart
  /// overlayColor: WidgetStatePropertyAll(context.colors.transparent)
  /// ```
  Color get transparent => surface.withAlpha(0);

  ColorScheme get toScheme => ColorScheme(
    primary: primary,
    primaryContainer: primaryContainer,
    onPrimary: onPrimary,
    onPrimaryContainer: primary,
    secondary: secondary,
    secondaryContainer: secondaryContainer,
    onSecondary: onSecondary,
    onSecondaryContainer: secondary,
    tertiary: tertiary,
    tertiaryContainer: tertiaryContainer,
    outline: outline,
    outlineVariant: outlineVariant,
    shadow: shadow,
    onTertiary: onTertiary,
    onTertiaryContainer: tertiary,
    surface: surface,
    surfaceContainer: surfaceVariant,
    onSurface: onSurface,
    onSurfaceVariant: onSurfaceVariant,
    error: error,
    errorContainer: errorContainer,
    onError: onError,
    onErrorContainer: error,
    brightness: brightness,
  );
}
