import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

enum SettingsSectionLayout {
  vertical,
  twoColumnCompact,
  twoColumnExpanded,
  threeColumn,
}

class AppSettingsSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final double? maxWidth;
  final List<Widget> children;

  /// Layout preference. On small screens this may collapse to vertical.
  final SettingsSectionLayout layout;

  /// Spacing between grid columns and rows.
  final double columnGap;
  final double rowGap;

  const AppSettingsSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
    this.maxWidth = 800,
    this.layout = SettingsSectionLayout.twoColumnCompact,
    this.columnGap = 24,
    this.rowGap = 24,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final effectiveLayout = _effectiveLayoutForWidth(layout, width);

    final columns = _buildColumns(effectiveLayout);
    final columnCount = columns.length;
    final rows = (children.length / columnCount).ceil().clamp(1, 9999);

    final grid = LayoutGrid(
      columnSizes: columns,
      rowSizes: List.generate(rows, (_) => auto),
      columnGap: columnGap,
      rowGap: rowGap,
      // Let the grid auto-place children row-wise.
      // autoPlacement: AutoPlacement.,
      children: children,
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: context.textTheme.titleSmall),
        const SizedBox(height: 8),
        Text(subtitle, style: context.textTheme.bodySmall),
        const SizedBox(height: 24),
        grid,
      ],
    );

    // Center + constrain width if desired.
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
      child: content,
    );
  }

  // ——— Helpers ———

  // Pick a sensible layout for the current width.
  SettingsSectionLayout _effectiveLayoutForWidth(
    SettingsSectionLayout preferred,
    double width,
  ) {
    // Collapse aggressively under 640px.
    if (width < 640) return SettingsSectionLayout.vertical;

    // Under ~900px, avoid 3 columns.
    if (width < 900 && preferred == SettingsSectionLayout.threeColumn) {
      return SettingsSectionLayout.twoColumnCompact;
    }

    return preferred;
  }

  // Define column tracks per layout.
  List<TrackSize> _buildColumns(SettingsSectionLayout l) {
    return switch (l) {
      SettingsSectionLayout.vertical => [1.fr],
      SettingsSectionLayout.twoColumnCompact => [auto, auto],
      SettingsSectionLayout.twoColumnExpanded => [1.fr, 1.fr],
      SettingsSectionLayout.threeColumn => [1.fr, 1.fr, 1.fr],
    };
  }
}
