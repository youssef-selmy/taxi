import 'package:better_design_system/organisms/step_indicator/connector_style.dart';
import 'package:better_design_system/organisms/step_indicator/step_glyph.dart';
import 'step_item.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

export 'step_item.dart';
export 'step_indicator_item_style.dart';
export 'connector_style.dart';

typedef BetterHorizontalStepIndicator = AppHorizontalStepIndicator;

class AppHorizontalStepIndicator<T> extends StatelessWidget {
  final List<StepIndicatorItem<T>> items;
  final T selectedStep;
  final StepIndicatorItemStyle style;
  final ConnectorStyle connectorStyle;

  const AppHorizontalStepIndicator({
    super.key,
    required this.items,
    required this.selectedStep,
    this.style = StepIndicatorItemStyle.rounded,
    this.connectorStyle = ConnectorStyle.arrow,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: items.mapIndexed((index, item) {
        final status = _getStatus(item);
        return Row(
          mainAxisSize: MainAxisSize.min,

          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            if (status == StepIndicatorItemStatus.completed) ...[
              Icon(
                style == StepIndicatorItemStyle.rounded
                    ? BetterIcons.checkmarkSquare02Filled
                    : BetterIcons.checkmarkCircle02Filled,
                color: context.colors.success,
              ),
            ],
            if (status != StepIndicatorItemStatus.completed) ...[
              AppStepGlygh(
                icon: item.icon,
                number: (index + 1).toString(),
                status: status,
                style: style,
              ),
            ],
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(item.label, style: context.textTheme.labelLarge),

                if (item.description != null)
                  Text(
                    item.description!,
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
              ],
            ),
            if (index != items.length - 1) ...[_separator(context, status)],
          ],
        );
      }).toList(),
    );
  }

  StepIndicatorItemStatus _getStatus(StepIndicatorItem<T> item) {
    final selectedIndex = items.indexWhere((e) => e.value == selectedStep);
    final itemIndex = items.indexWhere((e) => e.value == item.value);
    if (itemIndex == selectedIndex) {
      return StepIndicatorItemStatus.active;
    } else if (itemIndex < selectedIndex) {
      return StepIndicatorItemStatus.completed;
    } else if (itemIndex == selectedIndex + 1) {
      return StepIndicatorItemStatus.next;
    } else {
      return StepIndicatorItemStatus.upcoming;
    }
  }

  Widget _separator(BuildContext context, StepIndicatorItemStatus status) {
    return switch (connectorStyle) {
      ConnectorStyle.arrow => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          BetterIcons.arrowRight01Outline,
          color: status == StepIndicatorItemStatus.active
              ? context.colors.onSurface
              : context.colors.onSurfaceVariantLow,
        ),
      ),
      ConnectorStyle.line => Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        width: 70,
        height: 1,
        color: status == StepIndicatorItemStatus.active
            ? context.colors.outlineBold
            : context.colors.outlineVariant,
      ),
    };
  }
}
