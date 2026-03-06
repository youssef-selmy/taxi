part of 'extensions.dart';

extension TextStyleX on TextStyle {
  TextStyle variant(BuildContext context) =>
      apply(color: context.colors.onSurfaceVariant);

  TextStyle variantLow(BuildContext context) =>
      apply(color: context.colors.onSurfaceVariantLow);

  TextStyle primaryColor(BuildContext context) =>
      apply(color: context.colors.primary);

  TextStyle secondaryColor(BuildContext context) =>
      apply(color: context.colors.secondary);

  TextStyle tertiaryColor(BuildContext context) =>
      apply(color: context.colors.tertiary);
}
