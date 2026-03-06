import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:better_design_showcase/features/step_indicator/components/step_indicator_onboarding_horizontal_card.dart';
import 'package:better_design_showcase/features/step_indicator/components/step_indicator_onboarding_vertical_line_card.dart';
import 'package:better_design_showcase/features/step_indicator/components/step_indicator_onboarding_vertical_no_line_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class StepIndicatorScreen extends StatelessWidget {
  const StepIndicatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(
            currentTitle: 'Step Indicator',
            previousTitle: 'Blocks',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Step Indicator',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          const SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 576,
                title: 'Onboarding Vertical No Line Card',
                desktopSourceCode:
                    'blocks/step_indicator/step_indicator_onboarding_vertical_no_line_card.txt',
                desktopWidget:
                    const StepIndicatorOnboardingVerticalNoLineCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 658,
                title: 'Onboarding Vertical Line Card',
                desktopSourceCode:
                    'blocks/step_indicator/step_indicator_onboarding_vertical_line_card.txt',
                desktopWidget: const StepIndicatorOnboardingVerticalLineCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 236,
                title: 'Onboarding Horizontal Card',
                desktopSourceCode:
                    'blocks/step_indicator/step_indicator_onboarding_horizontal_card.txt',
                desktopWidget: const StepIndicatorOnboardingHorizontalCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
