import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/tooltip_bluetooth_card.dart';
import '../components/tooltip_design_assistant_card.dart';
import '../components/tooltip_starter_card.dart';

@RoutePage()
class TooltipScreen extends StatelessWidget {
  const TooltipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(previousTitle: 'Blocks', currentTitle: 'Tooltip'),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Tooltip',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 508,
                title: 'Starter Card',
                desktopSourceCode: 'blocks/tooltip/tooltip_starter_card.txt',
                desktopWidget: TooltipStarterCard(),
              ),

              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 336,
                title: 'Bluetooth Card',
                desktopSourceCode: 'blocks/tooltip/tooltip_bluetooth_card.txt',
                desktopWidget: TooltipBluetoothCard(),
              ),

              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 388,
                title: 'Design Assistant Card',
                desktopSourceCode:
                    'blocks/tooltip/tooltip_design_assistant_card.txt',
                desktopWidget: TooltipDesignAssistantCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
