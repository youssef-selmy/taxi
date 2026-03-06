import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_sidebar.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_dashboard/components/hr_platform_job_levels_card.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_dashboard/components/hr_platform_job_overview_card.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_dashboard/components/hr_platform_notes_card.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_dashboard/components/hr_platform_onboarding_calendar_card.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_dashboard/components/hr_platform_time_tracker_card.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_dashboard/components/hr_platform_time_worked_card.dart';
import 'package:better_design_system/atoms/buttons/icon_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/atoms/input_fields/dropdown/dropdown_field.dart';
import 'package:better_design_system/atoms/navbar/navbar_icon.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/organisms/profile_button/profile_button.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';

class HrPlatformDashboardDesktop extends StatelessWidget {
  const HrPlatformDashboardDesktop({super.key, this.header});

  final Widget? header;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (header != null) header!,
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HrPlatformSidebar(selectedItem: HrPlatformSidebarPage.dashboard),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text('Dashboard', style: context.textTheme.bodyLarge),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: 230,
                            child: AppDropdownField.single(
                              hint: '01 Jun 2025 - 31 December 2025',
                              type: DropdownFieldType.compact,
                              borderRadius: BorderRadius.circular(16),
                              items: [],
                            ),
                          ),
                          const Spacer(),
                          AppNavbarIcon(
                            icon: BetterIcons.search01Filled,
                            iconColor: context.colors.onSurfaceVariant,
                            iconSize: 22,
                            size: ButtonSize.medium,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          const SizedBox(width: 16),
                          AppNavbarIcon(
                            icon: BetterIcons.notification02Outline,
                            iconColor: context.colors.onSurfaceVariant,
                            iconSize: 24,
                            badgeNumber: 2,
                            size: ButtonSize.medium,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          const SizedBox(width: 16),
                          AppProfileButton(
                            avatarUrl: ImageFaker().person.four,
                            title: 'Paityn Baptista',
                            items: [
                              AppPopupMenuItem(
                                title: 'Profile',
                                onPressed: () {},
                                icon: BetterIcons.userFilled,
                              ),
                              AppPopupMenuItem(
                                title: 'Profile',
                                onPressed: () {},
                                icon: BetterIcons.wallet01Filled,
                              ),
                              AppPopupMenuItem(
                                hasDivider: true,
                                title: 'Logout',
                                onPressed: () {},
                                icon: BetterIcons.logout01Filled,
                                color: SemanticColor.error,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Text(
                            'Welcome, Paityn!',
                            style: context.textTheme.headlineSmall,
                          ),
                          const Spacer(),
                          AppToggleSwitchButtonGroup(
                            options: [
                              ToggleSwitchButtonGroupOption(
                                value: 'HR Dashboard',
                                label: 'HR Dashboard',
                              ),
                              ToggleSwitchButtonGroupOption(
                                value: 'Recruitment Dashboard',
                                label: 'Recruitment Dashboard',
                              ),
                            ],
                            selectedValue: 'HR Dashboard',
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 16,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              spacing: 16,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 16,
                                  children: [
                                    Expanded(
                                      child: HrPlatformJobOverviewCard(),
                                    ),
                                    Expanded(child: HrPlatformJobLevelsCard()),
                                  ],
                                ),
                                HrPlatformTimeWorkedCard(),
                                Row(
                                  spacing: 16,
                                  children: [
                                    Expanded(
                                      child: HrPlatformTimeTrackerCard(),
                                    ),
                                    Expanded(child: HrPlatformNotesCard()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(child: HrPlatformOnboardingCalendarCard()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
