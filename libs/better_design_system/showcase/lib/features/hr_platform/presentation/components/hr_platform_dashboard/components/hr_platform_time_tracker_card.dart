import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_card_container.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class HrPlatformTimeTrackerCard extends StatelessWidget {
  const HrPlatformTimeTrackerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return HrPlatformCardContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Time Tracker', style: context.textTheme.titleSmall),
              AppTextButton(
                onPressed: () {},
                text: 'View all',
                size: ButtonSize.small,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.colors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: context.colors.outline),
            ),
            child: Column(
              children: [
                AppDropdownField.single(
                  type: DropdownFieldType.compact,
                  hint: 'Select project',
                  items: [
                    AppDropdownItem(value: 'Today', title: 'Today'),
                    AppDropdownItem(value: 'Yesterday', title: 'Yesterday'),
                    AppDropdownItem(value: 'Last 7 Days', title: 'Last 7 Days'),
                  ],
                  borderRadius: BorderRadius.circular(6),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Awaiting',
                          style: context.textTheme.labelMedium!.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          '00:00:00',
                          style: context.textTheme.headlineMedium,
                        ),
                      ],
                    ),
                    AppFilledButton(
                      onPressed: () {},
                      prefixIcon: BetterIcons.playFilled,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: AppTextButton(
              onPressed: () {},
              text: 'View previous tasks',
              suffixIcon: BetterIcons.arrowRight01Outline,
              color: SemanticColor.primary,
              size: ButtonSize.small,
            ),
          ),
        ],
      ),
    );
  }
}
