import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_system/organisms/step_indicator/connector_style.dart';
import 'package:better_design_system/organisms/step_indicator/step_glyph.dart';
import 'step_item.dart';

export 'step_item.dart';
export 'step_indicator_item_style.dart';

typedef BetterVerticalStepIndicator = AppVerticalStepIndicator;

class AppVerticalStepIndicator<T> extends StatelessWidget {
  final List<StepIndicatorItem<T>> items;
  final T selectedStep;
  final StepIndicatorItemStyle style;
  final ConnectorStyle connectorStyle;

  const AppVerticalStepIndicator({
    super.key,
    required this.items,
    required this.selectedStep,
    this.style = StepIndicatorItemStyle.rounded,
    this.connectorStyle = ConnectorStyle.line,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      children: items.mapIndexed((index, item) {
        final status = _getStatus(item);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (status == StepIndicatorItemStatus.completed) ...[
                  Icon(
                    style == StepIndicatorItemStyle.rounded
                        ? BetterIcons.checkmarkSquare02Filled
                        : BetterIcons.checkmarkCircle02Filled,
                    color: context.colors.success,
                  ),
                ] else ...[
                  AppStepGlygh(
                    icon: item.icon,
                    number: (index + 1).toString(),
                    status: status,
                    style: style,
                  ),
                ],
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.label, style: context.textTheme.labelLarge),
                    if (item.description != null)
                      Text(
                        item.description!,
                        style: context.textTheme.labelMedium?.variant(context),
                      ),
                  ],
                ),

                if (connectorStyle == ConnectorStyle.arrow) ...[
                  const SizedBox(width: 8),
                  Icon(
                    BetterIcons.arrowRight01Outline,
                    color: _getStatus(item) == StepIndicatorItemStatus.active
                        ? context.colors.onSurface
                        : context.colors.onSurfaceVariantLow,
                  ),
                ],
              ],
            ),
            if (index < items.length - 1 &&
                connectorStyle == ConnectorStyle.line)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                width: 1,
                height: 26,
                color:
                    _getStatus(item) == StepIndicatorItemStatus.active ||
                        _getStatus(item) == StepIndicatorItemStatus.completed
                    ? context.colors.onSurface
                    : context.colors.outlineVariant,
              ),
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
}
