import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:better_design_showcase/features/tag/components/tag_send_message_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/tag_expertise_card.dart';
import '../components/tag_selected_filter_card.dart';

@RoutePage()
class TagScreen extends StatelessWidget {
  const TagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(previousTitle: 'Blocks', currentTitle: 'Tags'),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Tags',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 550,
                title: 'Send Message Card',
                desktopSourceCode: 'blocks/tag/tag_send_message_card.txt',
                desktopWidget: TagSendMessageCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 356,
                title: 'Expertise Card',
                desktopSourceCode: 'blocks/tag/tag_expertise_card.txt',
                desktopWidget: TagExpertiseCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 212,
                title: 'Selected Filter Card',
                desktopSourceCode: 'blocks/tag/tag_selected_filter_card.txt',
                desktopWidget: TagSelectedFilterCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
