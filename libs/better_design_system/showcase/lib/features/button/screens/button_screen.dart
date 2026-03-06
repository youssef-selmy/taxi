import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/button_create_account_card.dart';
import '../components/button_important_features_card.dart';
import '../components/button_programs_card.dart';
import '../components/button_social_post_card.dart';
import '../components/button_welcome_card.dart';

@RoutePage()
class ButtonScreen extends StatelessWidget {
  const ButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(previousTitle: 'Blocks', currentTitle: 'Buttons'),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Buttons',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: 948,
                title: 'Title',
                desktopSourceCode:
                    'blocks/button/button_create_account_card.txt',
                desktopWidget: ButtonCreateAccountCard(),
              ),

              AppPreviewComponent(
                maxWidth: 948,
                title: 'Title',
                desktopSourceCode: 'blocks/button/button_welcome_card.txt',
                desktopWidget: ButtonWelcomeCard(),
              ),

              AppPreviewComponent(
                maxWidth: 948,
                title: 'Title',
                desktopSourceCode:
                    'blocks/button/button_important_features_card.txt',
                desktopWidget: ButtonImportantFeaturesCard(),
              ),

              AppPreviewComponent(
                maxWidth: 948,
                title: 'Title',
                desktopSourceCode: 'blocks/button/button_social_post_card.txt',
                desktopWidget: ButtonSocialPostCard(),
              ),

              AppPreviewComponent(
                maxWidth: 948,
                title: 'Title',
                desktopSourceCode: 'blocks/button/button_programs_card.txt',
                desktopWidget: ButtonProgramsCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
