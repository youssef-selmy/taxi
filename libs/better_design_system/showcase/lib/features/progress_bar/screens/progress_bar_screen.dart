import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/progress_bar_component_documentation_card.dart';
import '../components/progress_bar_file_name_card.dart';
import '../components/progress_bar_survey_participation_card.dart';

@RoutePage()
class ProgressBarScreen extends StatelessWidget {
  const ProgressBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(
            previousTitle: 'Blocks',
            currentTitle: 'Progress Bar',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Progress Bar',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                borderRadius: BorderRadius.circular(16),
                maxWidth: 1016,
                title: 'Component Documentation Card',
                desktopSourceCode:
                    'blocks/progress_bar/progress_bar_component_documentation_card.txt',
                desktopWidget: ProgressBarComponentDocumentationCard(),
              ),
              AppPreviewComponent(
                borderRadius: BorderRadius.circular(16),
                maxWidth: 1016,
                title: 'Survey Participation Card',
                desktopSourceCode:
                    'blocks/progress_bar/progress_bar_survey_participation_card.txt',
                desktopWidget: ProgressBarSurveyParticipationCard(),
              ),
              AppPreviewComponent(
                borderRadius: BorderRadius.circular(10),
                maxWidth: 1016,
                title: 'File Name Card',
                desktopSourceCode:
                    'blocks/progress_bar/progress_bar_file_name_card.txt',
                desktopWidget: ProgressBarFileNameCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
