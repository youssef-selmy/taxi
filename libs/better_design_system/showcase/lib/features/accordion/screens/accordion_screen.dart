import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/accordion_list_first.dart';
import '../components/accordion_list_second.dart';

@RoutePage()
class AccordionScreen extends StatelessWidget {
  const AccordionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(
            previousTitle: 'Blocks',
            currentTitle: 'Accordion',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Accordion',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: 1016,
                title: 'List First',
                desktopSourceCode: 'blocks/accordion/accordion_list_first.txt',
                desktopWidget: AccordionListFirst(),
              ),

              AppPreviewComponent(
                maxWidth: 1016,
                title: 'List Second',
                desktopSourceCode: 'blocks/accordion/accordion_list_second.txt',
                desktopWidget: AccordionListSecond(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
