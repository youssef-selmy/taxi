import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

enum SemanticColor {
  primary,
  secondary,
  tertiary,
  neutral,
  error,
  success,
  warning,
  info,
  insight,
  white;

  Color main(BuildContext context) => switch (this) {
    SemanticColor.primary => context.colors.primary,
    SemanticColor.secondary => context.colors.secondary,
    SemanticColor.tertiary => context.colors.tertiary,
    SemanticColor.neutral => context.colors.onSurface,
    SemanticColor.error => context.colors.error,
    SemanticColor.success => context.colors.success,
    SemanticColor.warning => context.colors.warning,
    SemanticColor.info => context.colors.info,
    SemanticColor.insight => context.colors.insight,
    SemanticColor.white => Colors.white,
  };

  Color containerColor(BuildContext context) => switch (this) {
    SemanticColor.primary => context.colors.primaryContainer,
    SemanticColor.secondary => context.colors.secondaryContainer,
    SemanticColor.tertiary => context.colors.tertiaryContainer,
    SemanticColor.neutral => context.colors.surfaceContainer,
    SemanticColor.error => context.colors.errorContainer,
    SemanticColor.success => context.colors.successContainer,
    SemanticColor.warning => context.colors.warningContainer,
    SemanticColor.info => context.colors.infoContainer,
    SemanticColor.insight => context.colors.insightContainer,
    SemanticColor.white => Colors.white.withValues(alpha: 0.2),
  };

  Color onColor(BuildContext context) => switch (this) {
    SemanticColor.primary => context.colors.onPrimary,
    SemanticColor.secondary => context.colors.onSecondary,
    SemanticColor.tertiary => context.colors.onTertiary,
    SemanticColor.neutral => context.colors.surface,
    SemanticColor.error => context.colors.onError,
    SemanticColor.success => context.colors.onSuccess,
    SemanticColor.warning => context.colors.onWarning,
    SemanticColor.info => context.colors.onInfo,
    SemanticColor.insight => context.colors.onInsight,
    SemanticColor.white => Colors.black,
  };

  Color disabled(BuildContext context) => switch (this) {
    SemanticColor.primary => context.colors.primaryDisabled,
    SemanticColor.secondary => context.colors.secondaryDisabled,
    SemanticColor.tertiary => context.colors.tertiaryDisabled,
    SemanticColor.neutral => context.colors.onSurfaceDisabled,
    SemanticColor.error => context.colors.errorDisabled,
    SemanticColor.success => context.colors.successDisabled,
    SemanticColor.warning => context.colors.warningDisabled,
    SemanticColor.info => context.colors.infoDisabled,
    SemanticColor.insight => context.colors.insight,
    SemanticColor.white => Colors.white,
  };

  Color bold(BuildContext context) => switch (this) {
    SemanticColor.primary => context.colors.primaryBold,
    SemanticColor.secondary => context.colors.secondaryBold,
    SemanticColor.tertiary => context.colors.tertiaryBold,
    SemanticColor.neutral => context.colors.onSurface,
    SemanticColor.error => context.colors.errorBold,
    SemanticColor.success => context.colors.successBold,
    SemanticColor.warning => context.colors.warningBold,
    SemanticColor.info => context.colors.infoBold,
    SemanticColor.insight => context.colors.insightBold,
    SemanticColor.white => Colors.white,
  };

  Color variantLow(BuildContext context) => switch (this) {
    SemanticColor.primary => context.colors.primaryVariantLow,
    SemanticColor.secondary => context.colors.secondaryVariantLow,
    SemanticColor.tertiary => context.colors.tertiaryVariantLow,
    SemanticColor.neutral => context.colors.surfaceVariantLow,
    SemanticColor.error => context.colors.errorVariantLow,
    SemanticColor.success => context.colors.successVariantLow,
    SemanticColor.warning => context.colors.warningVariantLow,
    SemanticColor.info => context.colors.infoVariantLow,
    SemanticColor.insight => context.colors.insightVariantLow,
    SemanticColor.white => Colors.white,
  };

  Color variant(BuildContext context) => switch (this) {
    SemanticColor.primary => context.colors.primaryVariant,
    SemanticColor.secondary => context.colors.secondaryVariant,
    SemanticColor.tertiary => context.colors.tertiaryVariant,
    SemanticColor.neutral => context.colors.surfaceVariant,
    SemanticColor.error => context.colors.errorVariant,
    SemanticColor.success => context.colors.successVariant,
    SemanticColor.warning => context.colors.warningVariant,
    SemanticColor.info => context.colors.infoVariant,
    SemanticColor.insight => context.colors.insightVariant,
    SemanticColor.white => Colors.white,
  };
}
