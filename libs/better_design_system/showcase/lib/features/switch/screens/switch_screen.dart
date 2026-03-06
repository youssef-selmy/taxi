import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/switch_notification_setting_card.dart';
import '../components/switch_profile_card.dart';

@RoutePage()
class SwitchScreen extends StatelessWidget {
  const SwitchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(previousTitle: 'Blocks', currentTitle: 'Switch'),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Switch',
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
                maxHeight: 495,
                title: 'Notification Setting Card',
                desktopSourceCode:
                    'blocks/switch/switch_notification_setting_card.txt',
                desktopWidget: SwitchNotificationSettingCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 365,
                title: 'Profile Card',
                desktopSourceCode: 'blocks/switch/switch_profile_card.txt',
                desktopWidget: SwitchProfileCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
