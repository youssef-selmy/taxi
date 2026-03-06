import 'package:better_design_system/organisms/step_indicator/step_glyph.dart';
import 'package:better_design_system/organisms/step_indicator/vertical_step_indicator.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icons.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class StepIndicatorOnboardingVerticalLineCard extends StatelessWidget {
  const StepIndicatorOnboardingVerticalLineCard({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      StepIndicatorItem(label: 'Panel Language', value: 'Panel Language'),
      StepIndicatorItem(
        label: 'Personal Information',
        value: 'Personal Information',
      ),
      StepIndicatorItem(
        label: 'Company Information',
        value: 'Company Information',
      ),
      StepIndicatorItem(label: 'Google Map API', value: 'Google Map API'),
      StepIndicatorItem(label: 'MySQL', value: 'MySQL'),
      StepIndicatorItem(label: 'Redis', value: 'Redis'),
      StepIndicatorItem(label: 'Firebase', value: 'Firebase'),
      StepIndicatorItem(label: 'Confirmation', value: 'Confirmation'),
    ];
    const selectedStep = 'Personal Information';
    const style = StepIndicatorItemStyle.rounded;

    return SizedBox(
      width: 220,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ONBOARDING',
              style: context.textTheme.labelLarge!.copyWith(
                color: context.colors.onSurfaceVariantLow,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  items.mapIndexed((index, item) {
                    final status = _getStatus(items, selectedStep, item);
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
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
                            if (index < items.length - 1)
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                width: 1,
                                height: 26,
                                color:
                                    status == StepIndicatorItemStatus.active ||
                                            status ==
                                                StepIndicatorItemStatus
                                                    .completed
                                        ? context.colors.onSurface
                                        : context.colors.outlineVariant,
                              ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.label,
                          style: context.textTheme.labelLarge?.copyWith(
                            color:
                                status == StepIndicatorItemStatus.active
                                    ? context.colors.onSurface
                                    : context.colors.onSurfaceVariantLow,
                          ),
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
