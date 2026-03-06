import 'package:auto_route/auto_route.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_showcase/core/blocs/settings.cubit.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_dashboard/screens/hr_platform_dashboard.desktop.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_dashboard/screens/hr_platform_dashboard.mobile.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_kanban_page/screens/hr_platform_kanban_page.desktop.dart';
import 'package:better_design_showcase/features/hr_platform/presentation/components/hr_platform_kanban_page/screens/hr_platform_kanban_page.mobile.dart';
import 'package:flutter/material.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HrPlatformScreen extends StatelessWidget {
  const HrPlatformScreen({super.key});

  static const double _maxHeight = 1000;
  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBreadcrumbHeader(
            previousTitle: 'Templates',
            currentTitle: 'HR Platform',
          ),
          const SizedBox(height: 16),
          AppFeatureIntro(
            icon: Assets.images.iconsTwotone.userSquare.svg(
              width: 20,
              height: 20,
            ),
            iconBackgroundColor: context.colors.insight,
            iconColor: context.colors.onInsight,
            title: 'HR Platform',
            description:
                'A complete HR platform template including a dashboard and kanban page for managing human resources.',
          ),
          const SizedBox(height: 32),
          Column(
            spacing: 24,
            children: [
              AppPreviewComponent(
                maxHeight: _maxHeight,
                title: 'Dashboard',
                desktopWidget: HrPlatformDashboardDesktop(),
                mobileWidget: HrPlatformDashboardMobile(),
                desktopSourceCode:
                    'templates/hr_platform/hr_platform_dashboard.desktop.txt',
                mobileSourceCode:
                    'templates/hr_platform/hr_platform_dashboard.mobile.txt',
                initialTheme: context.read<SettingsCubit>().state.themeMode,
                fullScreenType: FullScreenType.dashboard,
              ),
              AppPreviewComponent(
                title: 'Kanban Page',
                maxHeight: _maxHeight,
                desktopWidget: HrPlatformKanbanPageDesktop(),
                mobileWidget: HrPlatformKanbanPageMobile(),
                desktopSourceCode:
                    'templates/hr_platform/hr_platform_kanban_page.desktop.txt',
                mobileSourceCode:
                    'templates/hr_platform/hr_platform_kanban_page.mobile.txt',
                initialTheme: context.read<SettingsCubit>().state.themeMode,
                fullScreenType: FullScreenType.dashboard,
              ),
            ],
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
