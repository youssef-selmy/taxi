import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/activity_log_card.dart';

@RoutePage()
class ActivityLogScreen extends StatelessWidget {
  const ActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(
            previousTitle: 'Blocks',
            currentTitle: 'Activity Log',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Activity Log',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          AppPreviewComponent(
            maxHeight: 558,
            title: 'Activity Log Card',
            desktopSourceCode: 'blocks/activity_log/activity_log_card.txt',
            desktopWidget: ActivityLogCard(),
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
