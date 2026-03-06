import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class InputComponentScreen extends StatelessWidget {
  const InputComponentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(
            currentTitle: 'Input Component',
            previousTitle: 'Blocks',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Input Component',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          const SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 948,
                title: 'Input Component First',
                desktopSourceCode: 'blocks/input_component/input_component.txt',
                desktopWidget: const Placeholder(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 752,
                title: 'Input Component Second',
                desktopSourceCode: 'blocks/input_component/input_component.txt',
                desktopWidget: const Placeholder(),
              ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
            ],
          ),
        ],
      ),
    );
  }
}
