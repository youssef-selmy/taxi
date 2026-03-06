import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/atoms/radio/radio.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_card_container.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class HrPlatformNotesCard extends StatefulWidget {
  const HrPlatformNotesCard({super.key});

  @override
  State<HrPlatformNotesCard> createState() => _HrPlatformNotesCardState();
}

class _HrPlatformNotesCardState extends State<HrPlatformNotesCard> {
  int selectedNoteId = -1; // -1 means no selection

  @override
  Widget build(BuildContext context) {
    return HrPlatformCardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Notes', style: context.textTheme.titleSmall),
              AppTextButton(
                onPressed: () {},
                text: 'View All',
                size: ButtonSize.small,
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 192,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: AppRadio<int>(
                          value: 0,
                          groupValue: selectedNoteId,
                          onTap: (value) {
                            setState(() {
                              selectedNoteId = value;
                            });
                          },
                          size: RadioSize.small,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Label', style: context.textTheme.labelLarge),
                            const SizedBox(height: 8),
                            Text(
                              'Description here',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                AppBadge(
                                  text: 'Today',
                                  size: BadgeSize.medium,
                                  isRounded: true,
                                ),
                                const SizedBox(width: 8),
                                AppBadge(
                                  text: 'Meeting',
                                  size: BadgeSize.medium,
                                  isRounded: true,
                                  color: SemanticColor.insight,
                                ),
                                const Spacer(),
                                Icon(
                                  BetterIcons.calendar03Outline,
                                  color: context.colors.onSurfaceVariant,
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Jun 01',
                                  style: context.textTheme.bodySmall!.copyWith(
                                    color: context.colors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9.5),
                    child: AppDivider(isDashed: true),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: AppRadio<int>(
                          value: 1,
                          groupValue: selectedNoteId,
                          onTap: (value) {
                            setState(() {
                              selectedNoteId = value;
                            });
                          },
                          size: RadioSize.small,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Label', style: context.textTheme.labelLarge),
                            const SizedBox(height: 8),
                            Text(
                              'Description here',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                AppBadge(
                                  text: 'Tomorrow',
                                  size: BadgeSize.medium,
                                  isRounded: true,
                                ),
                                const SizedBox(width: 8),
                                AppBadge(
                                  text: 'Work',
                                  size: BadgeSize.medium,
                                  isRounded: true,
                                  color: SemanticColor.success,
                                ),
                                const Spacer(),
                                Icon(
                                  BetterIcons.calendar03Outline,
                                  color: context.colors.onSurfaceVariant,
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Jun 01',
                                  style: context.textTheme.bodySmall!.copyWith(
                                    color: context.colors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9.5),
                    child: AppDivider(isDashed: true),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: AppRadio<int>(
                          value: 2,
                          groupValue: selectedNoteId,
                          onTap: (value) {
                            setState(() {
                              selectedNoteId = value;
                            });
                          },
                          size: RadioSize.small,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Label', style: context.textTheme.labelLarge),
                            const SizedBox(height: 8),
                            Text(
                              'Description here',
                              style: context.textTheme.bodySmall!.copyWith(
                                color: context.colors.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                AppBadge(
                                  text: 'Tomorrow',
                                  size: BadgeSize.medium,
                                  isRounded: true,
                                ),
                                const SizedBox(width: 8),
                                AppBadge(
                                  text: 'Work',
                                  size: BadgeSize.medium,
                                  isRounded: true,
                                  color: SemanticColor.success,
                                ),
                                const Spacer(),
                                Icon(
                                  BetterIcons.calendar03Outline,
                                  color: context.colors.onSurfaceVariant,
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Jun 01',
                                  style: context.textTheme.bodySmall!.copyWith(
                                    color: context.colors.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
