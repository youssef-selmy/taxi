import 'package:auto_route/auto_route.dart';
import 'package:better_assets/gen/assets.gen.dart';
import 'package:better_design_showcase/core/blocs/settings.cubit.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:better_design_showcase/core/router/app_router.dart';
import 'package:better_design_system/molecules/bottom_navigation/bottom_navigation.dart';
import 'package:better_design_system/molecules/bottom_navigation/bottom_navigation_fab.dart';
import 'package:better_design_system/utils/extensions/extensions.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/navigator.cubit.dart';
import '../components/fintech_dashboard_fifth.dart';
import '../components/fintech_dashboard_first.dart';
import '../components/fintech_dashboard_fourth.dart';
import '../components/fintech_dashboard_second.dart';
import '../components/fintech_dashboard_third.dart';

part 'fintech_screen.mobile.dart';

@RoutePage()
class FintechScreen extends StatelessWidget {
  const FintechScreen({super.key});
  static const double _maxHeight = 1000;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider.value(
        value: context.read<NavigatorCubit>(),
        child: DesktopPageContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBreadcrumbHeader(
                previousTitle: 'Templates',
                currentTitle: 'Fintech',
              ),
              const SizedBox(height: 16),
              AppFeatureIntro(
                icon: Assets.images.iconsTwotone.bank.svg(
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    context.colors.onWarning,
                    BlendMode.srcIn,
                  ),
                ),
                iconBackgroundColor: context.colors.warning,
                iconColor: context.colors.onWarning,
                title: 'Fintech',
                description:
                    'A complete fintech template including multiple dashboard layouts for financial applications.',
              ),
              const SizedBox(height: 32),
              Column(
                spacing: 24,
                children: [
                  AppPreviewComponent(
                    maxHeight: _maxHeight,
                    isMobileUnsupported: true,
                    initialTheme: context.read<SettingsCubit>().state.themeMode,
                    title: 'Dashboard First',
                    desktopWidget: FintechDashboardFirst(),
                    desktopSourceCode:
                        'templates/fintech/fintech_dashboard_first.txt',
                    fullScreenType: FullScreenType.dashboard,
                  ),
                  AppPreviewComponent(
                    isMobileUnsupported: true,
                    maxHeight: _maxHeight,
                    initialTheme: context.read<SettingsCubit>().state.themeMode,
                    title: 'Dashboard Second',
                    desktopWidget: FintechDashboardSecond(),
                    desktopSourceCode:
                        'templates/fintech/fintech_dashboard_second.txt',
                    fullScreenType: FullScreenType.dashboard,
                  ),
                  AppPreviewComponent(
                    isMobileUnsupported: true,
                    maxHeight: _maxHeight,
                    initialTheme: context.read<SettingsCubit>().state.themeMode,
                    title: 'Dashboard Third',
                    desktopWidget: FintechDashboardThird(),
                    desktopSourceCode:
                        'templates/fintech/fintech_dashboard_third.txt',
                    fullScreenType: FullScreenType.dashboard,
                  ),
                  AppPreviewComponent(
                    maxHeight: _maxHeight,
                    isMobileUnsupported: true,
                    initialTheme: context.read<SettingsCubit>().state.themeMode,
                    title: 'Dashboard Fourth',
                    desktopWidget: FintechDashboardFourth(),
                    desktopSourceCode:
                        'templates/fintech/fintech_dashboard_fourth.txt',
                    fullScreenType: FullScreenType.dashboard,
                  ),
                  AppPreviewComponent(
                    maxHeight: _maxHeight,
                    isMobileUnsupported: true,
                    initialTheme: context.read<SettingsCubit>().state.themeMode,
                    title: 'Dashboard Fifth',
                    desktopWidget: FintechDashboardFifth(),
                    desktopSourceCode:
                        'templates/fintech/fintech_dashboard_fifth.txt',
                    fullScreenType: FullScreenType.dashboard,
                  ),
                  AppPreviewComponent(
                    maxHeight: _maxHeight,
                    isBordered: false,
                    initialTheme: context.read<SettingsCubit>().state.themeMode,
                    title: 'Mobile',
                    mobileWidget: FintechScreenMobile(),
                    desktopSourceCode:
                        'templates/fintech/fintech_screen.mobile.txt',
                    fullScreenType: FullScreenType.dashboard,
                  ),
                ],
              ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
            ],
          ),
        ),
      ),
    );
  }
}
