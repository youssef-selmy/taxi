import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/radio_display_mode_card.dart';
import '../components/radio_share_setting_card.dart';

@RoutePage()
class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(previousTitle: 'Blocks', currentTitle: 'Radio'),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Radio',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 372,
                title: 'Display Mode Card',
                desktopSourceCode: 'blocks/radio/radio_display_mode_card.txt',
                desktopWidget: RadioDisplayModeCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 460,
                title: 'Share Setting Card',
                desktopSourceCode: 'blocks/radio/radio_share_setting_card.txt',
                desktopWidget: RadioShareSettingCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
