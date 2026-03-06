import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:better_design_showcase/features/file_upload/components/file_upload_documents_card.dart';
import 'package:better_design_showcase/features/file_upload/components/file_upload_file_card.dart';
import 'package:better_design_showcase/features/file_upload/components/file_upload_profile_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class FileUploadScreen extends StatelessWidget {
  const FileUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(
            currentTitle: 'File Upload',
            previousTitle: 'Blocks',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'File Upload',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          const SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 824,
                title: 'Documents Card',
                desktopSourceCode:
                    'blocks/file_upload/file_upload_documents_card.txt',
                desktopWidget: const FileUploadDocumentsCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 536,
                title: 'File Upload Card',
                desktopSourceCode:
                    'blocks/file_upload/file_upload_file_card.txt',
                desktopWidget: const FileUploadFileCard(),
              ),
              AppPreviewComponent(
                maxWidth: 1016,
                maxHeight: 432,
                title: 'Profile Image Card',
                desktopSourceCode:
                    'blocks/file_upload/file_upload_profile_image_card.txt',
                desktopWidget: const FileUploadProfileImageCard(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
