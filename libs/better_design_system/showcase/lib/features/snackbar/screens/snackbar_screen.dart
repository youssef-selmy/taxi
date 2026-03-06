import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/snackbar_preview.dart';
import '../components/snackbar_request_card.dart';
import '../components/snackbar_uploading_documents_card.dart';

@RoutePage()
class SnackbarScreen extends StatelessWidget {
  const SnackbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(
            previousTitle: 'Blocks',
            currentTitle: 'Snackbar',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Snackbar',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                borderRadius: BorderRadius.circular(24),
                maxHeight: 1173,
                title: 'Uploading Documents Card',
                desktopSourceCode:
                    'blocks/snackbar/snackbar_uploading_documents_card.txt',
                desktopWidget: SingleChildScrollView(
                  child: SnackbarPreview(
                    child: SnackbarUploadingDocumentsCard(),
                  ),
                ),
                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                borderRadius: BorderRadius.circular(24),
                maxHeight: 1173,
                title: 'Request Card',
                desktopSourceCode: 'blocks/snackbar/snackbar_request_card.txt',
                desktopWidget: SingleChildScrollView(
                  child: SnackbarPreview(child: SnackbarRequestCard()),
                ),
                fullScreenType: FullScreenType.dashboard,
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
