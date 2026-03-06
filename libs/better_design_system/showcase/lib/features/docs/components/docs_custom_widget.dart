import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import '../embedded_widgets/docs_custom_divider.dart';

/// Builds custom widgets embedded in markdown documentation.
Widget buildCustomWidget(String widgetName, BuildContext context) {
  return switch (widgetName) {
    'Divider' => DocsCustomDivider(),
    _ => Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.errorContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.colors.error),
      ),
      child: Text(
        'Unknown widget: $widgetName',
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colors.onSurface,
        ),
      ),
    ),
  };
}
