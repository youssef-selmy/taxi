import 'package:better_design_system/organisms/step_indicator/step_glyph.dart';
import 'package:better_design_system/organisms/step_indicator/vertical_step_indicator.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class StepIndicatorOnboardingHorizontalCard extends StatelessWidget {
  const StepIndicatorOnboardingHorizontalCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      StepIndicatorItem(
        label: 'Details',
        description: 'Enter details information',
        icon: BetterIcons.noteFilled,
        value: 'Details',
      ),
      StepIndicatorItem(
        label: 'Documents',
        description: 'Upload drivers documents',
        icon: BetterIcons.folder01Filled,
        value: 'Documents',
      ),
      StepIndicatorItem(
        label: 'Service Pricing',
        description: 'Select drivers services',
        icon: BetterIcons.creditCardFilled,
        value: 'Service Pricing',
      ),
    ];
    const selectedStep = 'Documents';
    const style = StepIndicatorItemStyle.rounded;

    return SizedBox(
      width: 1200,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  items.mapIndexed((index, item) {
                    final status = _getStatus(items, selectedStep, item);
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (status ==
                                    StepIndicatorItemStatus.completed) ...[
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
                                if (index < items.length - 1) ...[
                                  const SizedBox(width: 12),
                                  Container(
                                    width: 216,
                                    height: 1,
                                    color:
                                        index == 0
                                            ? context.colors.outlineVariant
                                            : context.colors.onSurface,
                                  ),
                                  const SizedBox(width: 12),
                                ],
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.label,
                              style: context.textTheme.labelLarge?.copyWith(
                                color:
                                    status == StepIndicatorItemStatus.active
                                        ? context.colors.onSurface
                                        : context.colors.onSurfaceVariantLow,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (item.description != null)
                              Text(
                                item.description!,
                                style: context.textTheme.labelMedium?.copyWith(
                                  color: context.colors.onSurfaceVariantLow,
                                ),
                              ),
                          ],
                        ),
                      ],
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  static StepIndicatorItemStatus _getStatus(
    List<StepIndicatorItem<String>> items,
    String selectedStep,
    StepIndicatorItem<String> item,
  ) {
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
