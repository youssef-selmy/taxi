part of 'theme.dart';

InputDecorationTheme inputTheme(TextTheme textTheme, ColorSystem colorSystem) =>
    InputDecorationTheme(
      fillColor: colorSystem.surfaceVariant,
      iconColor: colorSystem.onSurfaceVariant,
      prefixIconColor: colorSystem.onSurfaceVariant,
      suffixIconColor: colorSystem.onSurfaceVariant,
      labelStyle: textTheme.labelLarge,
      hintStyle: textTheme.bodyMedium?.apply(
        color: colorSystem.onSurfaceVariant,
      ),
      alignLabelWithHint: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorSystem.outline, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorSystem.outline, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorSystem.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorSystem.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorSystem.error, width: 2),
      ),
    );
