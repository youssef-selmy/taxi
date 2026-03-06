import 'package:auto_route/auto_route.dart';
import 'package:better_design_showcase/core/components/breadcrumb_header.dart';
import 'package:better_design_showcase/core/components/desktop_page_container.dart';
import 'package:better_design_showcase/core/components/feature_intro.dart';
import 'package:better_design_showcase/core/components/preview_component.dart';
import 'package:better_design_showcase/features/sidebar/components/sidebar_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

@RoutePage()
class SidebarScreen extends StatefulWidget {
  const SidebarScreen({super.key});

  @override
  State<SidebarScreen> createState() => _SidebarScreenState();
}

class _SidebarScreenState extends State<SidebarScreen> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return DesktopPageContainer(
      child: Column(
        children: [
          AppBreadcrumbHeader(currentTitle: 'Sidebar', previousTitle: 'Blocks'),
          const SizedBox(height: 16),
          AppFeatureIntro(
            title: 'Sidebar',
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          ),
          const SizedBox(height: 32),
          AppPreviewComponent(
            maxWidth: 1023,
            maxHeight: 1450,
            title: 'Sidebar Card',
            desktopSourceCode: 'blocks/sidebar/sidebar_card.txt',
            initialTheme: _themeMode,
            onThemeChanged: (mode) {
              setState(() {
                _themeMode = mode;
              });
            },
            desktopWidget: SidebarCard(
              selectedThemeMode: _themeMode,
              onThemeModeChanged: (mode) {
                setState(() {
                  _themeMode = mode;
                });
              },
            ),
          ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
