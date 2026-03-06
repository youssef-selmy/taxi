import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/toast_massage_error_style.dart';
import '../components/toast_massage_neutral_style.dart';
import '../components/toast_massage_success_style.dart';
import '../components/toast_massage_warning_style.dart';

@RoutePage()
class ToastMassageScreen extends StatelessWidget {
  const ToastMassageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(
            previousTitle: 'Blocks',
            currentTitle: 'Toast Massage',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Toast Massage',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxWidth: 1440,
                maxHeight: 1173,
                title: 'Success Style',
                desktopSourceCode:
                    'blocks/toast_massage/toast_massage_success_style.txt',
                desktopWidget: SingleChildScrollView(
                  child: ToastMassageSuccesstStyle(),
                ),
                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                maxWidth: 1440,
                maxHeight: 1173,
                title: 'Warning Style',
                desktopSourceCode:
                    'blocks/toast_massage/toast_massage_warning_style.txt',
                desktopWidget: SingleChildScrollView(
                  child: ToastMassageWarningStyle(),
                ),
                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                maxWidth: 1440,
                maxHeight: 1173,
                title: 'Error Style',
                desktopSourceCode:
                    'blocks/toast_massage/toast_massage_error_style.txt',
                desktopWidget: SingleChildScrollView(
                  child: ToastMassageErrorStyle(),
                ),
                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                maxWidth: 1440,
                maxHeight: 1173,
                title: 'Neutral Style',
                desktopSourceCode:
                    'blocks/toast_massage/toast_massage_neutral_style.txt',
                desktopWidget: SingleChildScrollView(
                  child: ToastMassageNeutralStyle(),
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
