import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:better_design_showcase/features/divider/components/divider_message_list_card.dart';
import 'package:better_design_showcase/features/divider/components/divider_setting_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class DividerScreen extends StatelessWidget {
  const DividerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(currentTitle: 'Divider', previousTitle: 'Blocks'),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Divider',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          const SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 408,
                title: 'Setting Card',
                desktopSourceCode: 'blocks/divider/divider_setting_card.txt',
                desktopWidget: const DividerSettingCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 432,
                title: 'Message List Card',
                desktopSourceCode:
                    'blocks/divider/divider_message_list_card.txt',
                desktopWidget: const DividerMessageListCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
