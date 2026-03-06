import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class IconContainerScreen extends StatelessWidget {
  const IconContainerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(
            currentTitle: 'Icon Container',
            previousTitle: 'Blocks',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Icon Container',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          const SizedBox(height: 32),
          AppPreviewComponent(
            maxWidth: 1016,
            maxHeight: 948,
            title: 'Icon Container Card',
            desktopSourceCode: 'blocks/icon_container/icon_container.txt',
            desktopWidget: const Placeholder(),
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
