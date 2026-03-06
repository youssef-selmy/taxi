import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/badge_feedback_card.dart';
import '../components/badge_notification_panel_card.dart';
import '../components/badge_user_lists_card.dart';

@RoutePage()
class BadgeScreen extends StatelessWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(previousTitle: 'Blocks', currentTitle: 'Badges'),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Badges',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: 806,
                title: 'User Lists Card',
                desktopSourceCode: 'blocks/badge/badge_user_lists_card.txt',
                desktopWidget: BadgeUserListsCard(),
              ),
              AppPreviewComponent(
                maxWidth: 806,
                title: 'Feedback Card',
                desktopSourceCode: 'blocks/badge/badge_feedback_card.txt',
                desktopWidget: BadgeFeedbackCard(),
              ),
              AppPreviewComponent(
                maxWidth: 806,
                title: 'Notification Panel Card',
                desktopSourceCode:
                    'blocks/badge/badge_notification_panel_card.txt',
                desktopWidget: BadgeNotificationPanelCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
