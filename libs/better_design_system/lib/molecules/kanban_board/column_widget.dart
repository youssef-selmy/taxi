import 'package:better_design_system/molecules/kanban_board/model/column.dart';
import 'package:better_design_system/molecules/kanban_board/model/header.dart';
import 'package:better_design_system/molecules/kanban_board/task_card_widget.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class KanbanColumn<S> extends StatelessWidget {
  final KColumn column;

  final S? hoveredColumnIndex;

  const KanbanColumn({
    super.key,
    required this.column,

    this.hoveredColumnIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isDetachedStyle = column.header.style == KColumnHeaderStyle.detached;

    // If detached style, header is outside the main container
    if (isDetachedStyle) {
      return SizedBox(
        width: 352,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleColumn(context),
            const SizedBox(height: 16),
            Container(
              constraints: const BoxConstraints(minHeight: 200),
              decoration: _getContainerDecoration(context),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Stack(
                  children: [
                    _buildListItemsColumn(context),
                    if (hoveredColumnIndex != null &&
                        column.value == hoveredColumnIndex)
                      _buildDropOverlay(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Contained style - header inside the container
    return Container(
      width: 352,
      constraints: const BoxConstraints(minHeight: 200),
      decoration: _getContainerDecoration(context),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTitleColumn(context),
                const SizedBox(height: 4),
                _buildDivider(context),
                const SizedBox(height: 4),
                _buildListItemsColumn(context),
              ],
            ),
            if (hoveredColumnIndex != null &&
                column.value == hoveredColumnIndex)
              _buildDropOverlay(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDropOverlay(BuildContext context) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.surface.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text('Drop Here', style: context.textTheme.titleLarge),
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.5),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: context.colors.outline,
        ),
      ),
    );
  }

  BoxDecoration _getContainerDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: context.colors.surfaceVariantLow,
      border: Border.all(color: context.colors.outline),
    );
  }

  Widget _buildTitleColumn(BuildContext context) {
    return _buildHeaderByStyle(
      context,
      style: column.header.style,
      title: column.header.title,
      icon: column.header.icon,
      prefix: column.header.prefix,
      trailing: column.header.trailing,
      color: column.header.color,
    );
  }

  Widget _buildHeaderByStyle(
    BuildContext context, {
    required KColumnHeaderStyle style,
    required String title,
    IconData? icon,
    Widget? prefix,
    List<Widget>? trailing,
    SemanticColor? color,
  }) {
    switch (style) {
      case KColumnHeaderStyle.contained:
        return _buildContainedHeader(
          context,
          title: title,
          icon: icon,
          prefix: prefix,
          trailing: trailing,
          color: color,
        );
      case KColumnHeaderStyle.detached:
        return _buildDetachedHeader(
          context,
          title: title,
          icon: icon,
          prefix: prefix,
          trailing: trailing,
          color: color,
        );
    }
  }

  Widget _buildContainedHeader(
    BuildContext context, {
    required String title,
    IconData? icon,
    Widget? prefix,
    List<Widget>? trailing,
    SemanticColor? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 8,
          children: [
            if (prefix != null)
              prefix
            else if (icon != null)
              Icon(icon, color: context.colors.onSurfaceVariant, size: 20),
            Text(title, style: context.textTheme.labelLarge),
          ],
        ),
        if (trailing != null && trailing.isNotEmpty)
          Row(spacing: 8, children: [...trailing]),
      ],
    );
  }

  Widget _buildDetachedHeader(
    BuildContext context, {
    required String title,
    IconData? icon,
    Widget? prefix,
    List<Widget>? trailing,
    SemanticColor? color,
  }) {
    final backgroundColor =
        color?.containerColor(context) ?? context.colors.surface;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 8,
            children: [
              if (prefix != null)
                prefix
              else if (icon != null)
                Icon(icon, color: context.colors.onSurface, size: 20),
              Text(title, style: context.textTheme.labelLarge),
            ],
          ),
          if (trailing != null && trailing.isNotEmpty)
            Row(children: [...trailing]),
        ],
      ),
    );
  }

  Widget _buildListItemsColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ...column.children
            .mapIndexed(
              (itemIndex, widget) => ItemCard(
                key: ValueKey(widget),
                cardItem: widget,
                columnIndex: column.value,
              ),
            )
            .toList()
            .separated(separator: const SizedBox(height: 12)),
      ],
    );
  }
}
