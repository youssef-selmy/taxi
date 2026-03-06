import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/notification_preview.dart';
import '../components/notification_right_sheet.dart';

@RoutePage()
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(
            previousTitle: 'Blocks',
            currentTitle: 'Notification',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Notification',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: 1440,
                maxHeight: 1173,
                title: 'Right Sheet',
                desktopSourceCode:
                    'blocks/notification/notification_right_sheet.txt',
                desktopWidget: SingleChildScrollView(
                  child: NotificationPreview(
                    notification: NotificationRightSheet(),
                  ),
                ),
                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                maxWidth: 1440,
                maxHeight: 1173,
                title: 'Right Sheet Style B',
                desktopSourceCode:
                    'blocks/notification/notification_right_sheet.txt',
                desktopWidget: SingleChildScrollView(
                  child: NotificationPreview(
                    notification: NotificationRightSheet(
                      style: NotificationRightSheetStyle.styleB,
                    ),
                  ),
                ),
                fullScreenType: FullScreenType.dashboard,
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
