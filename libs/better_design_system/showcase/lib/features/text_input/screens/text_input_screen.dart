import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:better_design_showcase/features/text_input/components/text_input_card_information_card.dart';
import 'package:better_design_showcase/features/text_input/components/text_input_create_an_account_card.dart';
import 'package:better_design_showcase/features/text_input/components/text_input_create_new_project_card.dart';
import 'package:better_design_showcase/features/text_input/components/text_input_login_card.dart';
import 'package:better_design_showcase/features/text_input/components/text_input_share_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class TextInputScreen extends StatelessWidget {
  const TextInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(
            currentTitle: 'Text Input',
            previousTitle: 'Blocks',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Text Input',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          const SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 640,
                title: 'Login Card',
                desktopSourceCode:
                    'blocks/text_input/text_input_login_card.txt',
                desktopWidget: const TextInputLoginCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 472,
                title: 'Share Card',
                desktopSourceCode:
                    'blocks/text_input/text_input_share_card.txt',
                desktopWidget: const TextInputShareCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 508,
                title: 'Create An Account Card',
                desktopSourceCode:
                    'blocks/text_input/text_input_create_an_account_card.txt',
                desktopWidget: const TextInputCreateAnAccountCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 832,
                title: 'Card Information Card',
                desktopSourceCode:
                    'blocks/text_input/text_input_card_information_card.txt',
                desktopWidget: const TextInputCardInformationCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 720,
                title: 'Create New Project Card',
                desktopSourceCode:
                    'blocks/text_input/text_input_create_new_project_card.txt',
                desktopWidget: const TextInputCreateNewProjectCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
