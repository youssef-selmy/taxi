import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/avatar_information_details_card.dart';
import '../components/avatar_user_details_card.dart';
import '../components/avatar_user_lists_card.dart';

@RoutePage()
class AvatarScreen extends StatelessWidget {
  const AvatarScreen({super.key});
  static const double width = 806;
  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(previousTitle: 'Blocks', currentTitle: 'Avatars'),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Avatars',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: width,
                title: 'User Lists Card',
                desktopSourceCode: 'blocks/avatar/avatar_user_lists_card.txt',
                desktopWidget: AvatarUserListsCard(),
              ),
              AppPreviewComponent(
                maxWidth: width,
                title: 'Information Details Card',
                desktopSourceCode:
                    'blocks/avatar/avatar_information_details_card.txt',
                desktopWidget: AvatarInformationDetailsCard(),
              ),
              AppPreviewComponent(
                maxWidth: width,
                title: 'User Details Card',
                desktopSourceCode: 'blocks/avatar/avatar_user_details_card.txt',
                desktopWidget: AvatarUserDetailsCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
