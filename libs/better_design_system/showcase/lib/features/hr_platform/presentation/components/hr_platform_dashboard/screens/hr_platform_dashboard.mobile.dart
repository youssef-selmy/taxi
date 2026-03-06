import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_dashboard/components/hr_platform_job_levels_card.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_dashboard/components/hr_platform_job_overview_card.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_dashboard/components/hr_platform_notes_card.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_dashboard/components/hr_platform_onboarding_calendar_card.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_dashboard/components/hr_platform_time_tracker_card.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_dashboard/components/hr_platform_time_worked_card.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_mobile_top_bar.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

class HrPlatformDashboardMobile extends StatelessWidget {
  const HrPlatformDashboardMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            HrPlatformMobileTopBar.style1(
              title: 'Dashboard',
              prefixIcon: BetterIcons.menu01Outline,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, Paityn!',
                    style: context.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  AppToggleSwitchButtonGroup(
                    isExpanded: true,
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
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: Column(
                spacing: 8,
                children: [
                  const HrPlatformTimeTrackerCard(),
                  const HrPlatformJobOverviewCard(),
                  const HrPlatformNotesCard(),
                  const HrPlatformJobLevelsCard(),
                  const HrPlatformTimeWorkedCard(isMobile: true),
                  const HrPlatformOnboardingCalendarCard(isMobile: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
