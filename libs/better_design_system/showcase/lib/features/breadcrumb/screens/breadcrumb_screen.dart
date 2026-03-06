import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/breadcrumb_branding_guidelines_card.dart';
import '../components/breadcrumb_component_library_card.dart';

@RoutePage()
class BreadcrumbScreen extends StatelessWidget {
  const BreadcrumbScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(
            previousTitle: 'Blocks',
            currentTitle: 'Breadcrumbs',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Breadcrumbs',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: 1080,
                title: 'Component Library Card',
                desktopSourceCode:
                    'blocks/breadcrumb/breadcrumb_component_library_card.txt',
                desktopWidget: BreadcrumbComponentLibraryCard(),
              ),

              AppPreviewComponent(
                maxWidth: 1080,
                title: 'Branding Guidelines Card',
                desktopSourceCode:
                    'blocks/breadcrumb/breadcrumb_branding_guidelines_card.txt',
                desktopWidget: BreadcrumbBrandingGuidelinesCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
