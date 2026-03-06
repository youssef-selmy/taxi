import 'package:better_design_system/atoms/divider/divider.dart';
import 'package:better_design_system/molecules/date_picker/date_picker.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_card_container.dart';
import 'package:flutter/material.dart';

class HrPlatformOnboardingCalendarCard extends StatelessWidget {
  const HrPlatformOnboardingCalendarCard({super.key, this.isMobile = false});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return HrPlatformCardContainer(
        padding: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Onboarding Calendar',
                  style: context.textTheme.titleSmall,
                ),
                const SizedBox(height: 12),
                AppDatePicker(
                  fullBleed: true,
                  onChanged: (context) {},
                  events: [
                    DateTime.now().subtract(const Duration(days: 6)),
                    DateTime.now().subtract(const Duration(days: 3)),
                    DateTime.now().add(const Duration(days: 2)),
                    DateTime.now().add(const Duration(days: 5)),
                  ],
                ),
                const SizedBox(height: 16),
                AppDivider(isDashed: true),
                const SizedBox(height: 16),
                Text('Upcoming schedule', style: context.textTheme.labelLarge),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text('10:00 AM', style: context.textTheme.labelLarge),
                    const SizedBox(width: 14),
                    Expanded(
                      child: SizedBox(
                        height: 70,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: context.colors.insightContainer,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.only(left: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'MEETING',
                                      style: context.textTheme.bodySmall!
                                          .copyWith(
                                            color: context.colors.insightBold,
                                          ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      'Product Team',
                                      style: context.textTheme.bodyLarge!
                                          .copyWith(
                                            color: context.colors.insightBold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 13,
                              bottom: 13,
                              child: Container(
                                width: 3,
                                decoration: BoxDecoration(
                                  color: context.colors.insightBold,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text('12:00 PM', style: context.textTheme.labelLarge),
                    const SizedBox(width: 14),
                    Expanded(
                      child: SizedBox(
                        height: 70,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: context.colors.secondaryContainer,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.only(left: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Event',
                                      style: context.textTheme.bodySmall!
                                          .copyWith(
                                            color: context.colors.secondaryBold,
                                          ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      'Marketing Campaign',
                                      style: context.textTheme.bodyLarge!
                                          .copyWith(
                                            color: context.colors.secondaryBold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 13,
                              bottom: 13,
                              child: Container(
                                width: 3,
                                decoration: BoxDecoration(
                                  color: context.colors.secondaryBold,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text('03:30 PM', style: context.textTheme.labelLarge),
                    const SizedBox(width: 14),
                    Expanded(
                      child: SizedBox(
                        height: 70,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: context.colors.infoContainer,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.only(left: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Interview',
                                      style: context.textTheme.bodySmall!
                                          .copyWith(
                                            color: context.colors.infoBold,
                                          ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      'Interview with Alex',
                                      style: context.textTheme.bodyLarge!
                                          .copyWith(
                                            color: context.colors.infoBold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 13,
                              bottom: 13,
                              child: Container(
                                width: 3,
                                decoration: BoxDecoration(
                                  color: context.colors.infoBold,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text('04:00 AM', style: context.textTheme.labelLarge),
                    const SizedBox(width: 14),
                    Expanded(
                      child: SizedBox(
                        height: 70,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: context.colors.insightContainer,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.only(left: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'MEETING',
                                      style: context.textTheme.bodySmall!
                                          .copyWith(
                                            color: context.colors.insightBold,
                                          ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      'HR Team',
                                      style: context.textTheme.bodyLarge!
                                          .copyWith(
                                            color: context.colors.insightBold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 13,
                              bottom: 13,
                              child: Container(
                                width: 3,
                                decoration: BoxDecoration(
                                  color: context.colors.insightBold,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text('07:00 PM', style: context.textTheme.labelLarge),
                    const SizedBox(width: 14),
                    Expanded(
                      child: SizedBox(
                        height: 70,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: context.colors.secondaryContainer,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.only(left: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Event',
                                      style: context.textTheme.bodySmall!
                                          .copyWith(
                                            color: context.colors.secondaryBold,
                                          ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      'Product Presentation',
                                      style: context.textTheme.bodyLarge!
                                          .copyWith(
                                            color: context.colors.secondaryBold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 13,
                              bottom: 13,
                              child: Container(
                                width: 3,
                                decoration: BoxDecoration(
                                  color: context.colors.secondaryBold,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text('09:00 PM', style: context.textTheme.labelLarge),
                    const SizedBox(width: 14),
                    Expanded(
                      child: SizedBox(
                        height: 70,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: context.colors.infoContainer,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.only(left: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'MEETING',
                                      style: context.textTheme.bodySmall!
                                          .copyWith(
                                            color: context.colors.infoBold,
                                          ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      'R&D Team',
                                      style: context.textTheme.bodyLarge!
                                          .copyWith(
                                            color: context.colors.infoBold,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 5,
                              top: 13,
                              bottom: 13,
                              child: Container(
                                width: 3,
                                decoration: BoxDecoration(
                                  color: context.colors.infoBold,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return HrPlatformCardContainer(
      height: 860,
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Onboarding Calendar', style: context.textTheme.titleSmall),
              const SizedBox(height: 12),
              AppDatePicker(
                fullBleed: true,
                onChanged: (context) {},
                events: [
                  DateTime.now().subtract(const Duration(days: 6)),
                  DateTime.now().subtract(const Duration(days: 3)),
                  DateTime.now().add(const Duration(days: 2)),
                  DateTime.now().add(const Duration(days: 5)),
                ],
              ),
              const SizedBox(height: 16),
              AppDivider(isDashed: true),
              const SizedBox(height: 16),
              Text('Upcoming schedule', style: context.textTheme.labelLarge),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text('10:00 AM', style: context.textTheme.labelLarge),
                  const SizedBox(width: 14),
                  Expanded(
                    child: SizedBox(
                      height: 70,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: context.colors.insightContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.only(left: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'MEETING',
                                    style: context.textTheme.bodySmall!
                                        .copyWith(
                                          color: context.colors.insightBold,
                                        ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Product Team',
                                    style: context.textTheme.bodyLarge!
                                        .copyWith(
                                          color: context.colors.insightBold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 13,
                            bottom: 13,
                            child: Container(
                              width: 3,
                              decoration: BoxDecoration(
                                color: context.colors.insightBold,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text('12:00 PM', style: context.textTheme.labelLarge),
                  const SizedBox(width: 14),
                  Expanded(
                    child: SizedBox(
                      height: 70,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: context.colors.secondaryContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.only(left: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Event',
                                    style: context.textTheme.bodySmall!
                                        .copyWith(
                                          color: context.colors.secondaryBold,
                                        ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Marketing Campaign',
                                    style: context.textTheme.bodyLarge!
                                        .copyWith(
                                          color: context.colors.secondaryBold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 13,
                            bottom: 13,
                            child: Container(
                              width: 3,
                              decoration: BoxDecoration(
                                color: context.colors.secondaryBold,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text('03:30 PM', style: context.textTheme.labelLarge),
                  const SizedBox(width: 14),
                  Expanded(
                    child: SizedBox(
                      height: 70,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: context.colors.infoContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.only(left: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Interview',
                                    style: context.textTheme.bodySmall!
                                        .copyWith(
                                          color: context.colors.infoBold,
                                        ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Interview with Alex',
                                    style: context.textTheme.bodyLarge!
                                        .copyWith(
                                          color: context.colors.infoBold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 13,
                            bottom: 13,
                            child: Container(
                              width: 3,
                              decoration: BoxDecoration(
                                color: context.colors.infoBold,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text('04:00 AM', style: context.textTheme.labelLarge),
                  const SizedBox(width: 14),
                  Expanded(
                    child: SizedBox(
                      height: 70,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: context.colors.insightContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.only(left: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'MEETING',
                                    style: context.textTheme.bodySmall!
                                        .copyWith(
                                          color: context.colors.insightBold,
                                        ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'HR Team',
                                    style: context.textTheme.bodyLarge!
                                        .copyWith(
                                          color: context.colors.insightBold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 13,
                            bottom: 13,
                            child: Container(
                              width: 3,
                              decoration: BoxDecoration(
                                color: context.colors.insightBold,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text('07:00 PM', style: context.textTheme.labelLarge),
                  const SizedBox(width: 14),
                  Expanded(
                    child: SizedBox(
                      height: 70,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: context.colors.secondaryContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.only(left: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Event',
                                    style: context.textTheme.bodySmall!
                                        .copyWith(
                                          color: context.colors.secondaryBold,
                                        ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'Product Presentation',
                                    style: context.textTheme.bodyLarge!
                                        .copyWith(
                                          color: context.colors.secondaryBold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 13,
                            bottom: 13,
                            child: Container(
                              width: 3,
                              decoration: BoxDecoration(
                                color: context.colors.secondaryBold,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text('09:00 PM', style: context.textTheme.labelLarge),
                  const SizedBox(width: 14),
                  Expanded(
                    child: SizedBox(
                      height: 70,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: context.colors.infoContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.only(left: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'MEETING',
                                    style: context.textTheme.bodySmall!
                                        .copyWith(
                                          color: context.colors.infoBold,
                                        ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    'R&D Team',
                                    style: context.textTheme.bodyLarge!
                                        .copyWith(
                                          color: context.colors.infoBold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 13,
                            bottom: 13,
                            child: Container(
                              width: 3,
                              decoration: BoxDecoration(
                                color: context.colors.infoBold,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
