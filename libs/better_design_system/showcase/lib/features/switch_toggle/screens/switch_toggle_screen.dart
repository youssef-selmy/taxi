import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/switch_toggle_feedback_card.dart';
import '../components/switch_toggle_select_theme_card.dart';
import '../components/switch_toggle_service_selector_card.dart';

@RoutePage()
class SwitchToggleScreen extends StatelessWidget {
  const SwitchToggleScreen({super.key});

  static const double _maxWidth = 1016;

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(
            previousTitle: 'Blocks',
            currentTitle: 'Switch Toggle',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Switch Toggle',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: _maxWidth,
                title: 'Select Theme Card',
                desktopSourceCode:
                    'blocks/switch_toggle/switch_toggle_select_theme_card.txt',
                desktopWidget: SwitchToggleSelectThemeCard(),
              ),
              AppPreviewComponent(
                maxWidth: _maxWidth,
                title: 'Feedback Card',
                desktopSourceCode:
                    'blocks/switch_toggle/switch_toggle_feedback_card.txt',
                desktopWidget: SwitchToggleFeedbackCard(),
              ),
              AppPreviewComponent(
                maxWidth: _maxWidth,
                title: 'Service Selector Card',
                desktopSourceCode:
                    'blocks/switch_toggle/switch_toggle_service_selector_card.txt',
                desktopWidget: SwitchToggleServiceSelectorCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
