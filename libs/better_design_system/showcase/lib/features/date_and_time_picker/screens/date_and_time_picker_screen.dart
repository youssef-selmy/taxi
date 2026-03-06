import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../components/date_and_time_picker_range.dart';
import '../components/date_and_time_picker_single.dart';

@RoutePage()
class DateAndTimePickerScreen extends StatelessWidget {
  const DateAndTimePickerScreen({super.key});
  static const double width = 1016;
  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(
            previousTitle: 'Blocks',
            currentTitle: 'Date & Time Picker',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            iconBackgroundColor: context.colors.warning,
            iconColor: context.colors.onWarning,
            title: 'Date & Time Picker',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                borderRadius: BorderRadius.circular(16),
                maxWidth: width,
                maxHeight: 750,
                title: 'Single Picker',
                desktopSourceCode:
                    'blocks/date_and_time_picker/date_and_time_picker_single.txt',
                desktopWidget: DateAndTimePickerSingle(),
              ),
              AppPreviewComponent(
                borderRadius: BorderRadius.circular(16),
                maxWidth: width,
                maxHeight: 770,
                title: 'Range Picker',
                desktopSourceCode:
                    'blocks/date_and_time_picker/date_and_time_picker_range.txt',
                desktopWidget: DateAndTimePickerRange(),
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
