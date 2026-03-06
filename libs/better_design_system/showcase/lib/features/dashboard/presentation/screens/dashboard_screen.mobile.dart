part of 'dashboard_screen.dart';

enum Pages1 { getStarted, welcome, installation, theming, darkMode, figma }

enum Pages2 {
  foundations,
  typography,
  colors,
  radius,
  spacing,
  shadowStyle,
  blurStyle,
}

class DashboardScreenMobile extends StatefulWidget {
  const DashboardScreenMobile({super.key});

  @override
  State<DashboardScreenMobile> createState() => _DashboardScreenMobileState();
}

class _DashboardScreenMobileState extends State<DashboardScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppNavbar(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              prefix: Row(
                children: [
                  Assets.images.logo.image(height: 28),
                  const SizedBox(width: 4),
                  Text('BetterUI', style: context.textTheme.titleSmall),
                ],
              ),
              suffix: Row(
                children: [
                  const SizedBox(width: 8),
                  AppTopBarIconButton(
                    icon: BetterIcons.search01Filled,
                    iconColor: context.colors.onSurfaceVariant,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  AppTopBarIconButton(
                    icon: BetterIcons.menu11Outline,
                    iconColor: context.colors.onSurfaceVariant,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => DashboardScreenDialog(),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(child: AutoRouter()),
          ],
        ),
      ),
    );
  }
}

class DashboardScreenDialog extends StatefulWidget {
  const DashboardScreenDialog({super.key});

  @override
  State<DashboardScreenDialog> createState() => _DashboardScreenDialogState();
}

class _DashboardScreenDialogState extends State<DashboardScreenDialog> {
  String? selectedTab;
  ThemeMode _themeMode = ThemeMode.light;
  Pages1 _selectedPage1 = Pages1.getStarted;
  Pages2 _selectedPage2 = Pages2.foundations;
  bool _isGetStartedExpanded = true;
  bool _isFoundationsExpanded = true;

  String? _getCurrentScreenTab() {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == HomeScreen().toString()) return 'Themes';
    if (currentRoute == TemplatesScreen().toString()) return 'Templates';
    if (currentRoute == BlocksRoute().toString()) return 'Blocks';
    // Add other routes as needed
    return currentRoute;
  }

  void _handleTabPress(String title) {
    setState(() {
      selectedTab = title;
    });

    // Navigate to different screens based on tab selection
    switch (title) {
      case 'Docs':
        break;
      case 'Blocks':
        context.router.replaceAll([BlocksRoute()]);
        break;
      case 'Templates':
        context.router.replaceAll([TemplatesRoute()]);
        break;
      case 'Themes':
        context.router.replaceAll([HomeRoute()]);

        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedTab = _getCurrentScreenTab();
  }

  @override
  Widget build(BuildContext context) {
    return AppResponsiveDialog(
      defaultDialogType: DialogType.fullScreen,
      desktopDialogType: DialogType.fullScreen,
      title: '',
      onClosePressed: () {
        context.router.pop();
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...(['Docs', 'Blocks', 'Templates', 'Themes']
                    .map(
                      (title) => AppTabMenuHorizontalItem<String?>(
                        item: TabMenuHorizontalOption<String?>(
                          title: title,
                          value: title,
                        ),
                        selectedValue: selectedTab,
                        onPressed: (_) {
                          _handleTabPress(title);
                          context.router.pop();
                        },
                        style: TabMenuHorizontalStyle.soft,
                        color: SemanticColor.primary,
                      ),
                    )
                    .expand((widget) => [widget, const SizedBox(width: 6)])
                    .toList()
                  ..removeLast()),
              ],
            ),
            const SizedBox(height: 16),
            const AppDivider(),
            const SizedBox(height: 16),
            Text(
              'Theme',
              style: context.textTheme.labelLarge?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<SettingsCubit, SettingsState>(
                    builder: (context, state) {
                      return AppThemeDropdown(
                        initialValue: state.theme,
                        onChanged: (theme) {
                          context.read<SettingsCubit>().changeTheme(theme!);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                AppToggleSwitchButtonGroup<ThemeMode>(
                  options: [
                    ToggleSwitchButtonGroupOption<ThemeMode>(
                      value: ThemeMode.light,
                      icon: BetterIcons.sun02Outline,
                      selectedIcon: BetterIcons.sun01Filled,
                    ),
                    ToggleSwitchButtonGroupOption<ThemeMode>(
                      value: ThemeMode.dark,
                      icon: BetterIcons.moon02Outline,
                      selectedIcon: BetterIcons.moon02Filled,
                    ),
                  ],
                  selectedValue: _themeMode,
                  onChanged: (ThemeMode value) {
                    setState(() {
                      _themeMode = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            const AppDivider(),
            const SizedBox(height: 16),
            AppSidebarNavigationItem<Pages1>(
              style: SidebarNavigationItemStyle.nuetral,
              selectedItem: _selectedPage1,
              isItemExpanded: _isGetStartedExpanded,
              onItemSelected: (value) {
                setState(() {
                  _selectedPage1 = value;
                });
              },
              onItemExpansionChanged: (page, isExpanded) {
                setState(() {
                  _isGetStartedExpanded = isExpanded;
                });
              },
              item: NavigationItem<Pages1>(
                title: 'Get Started',
                value: Pages1.getStarted,
                subItems: [
                  NavigationSubItem(title: 'Welcome', value: Pages1.welcome),
                  NavigationSubItem(
                    title: 'Installation',
                    value: Pages1.installation,
                  ),
                  NavigationSubItem(title: 'Theming', value: Pages1.theming),
                  NavigationSubItem(title: 'Dark Mode', value: Pages1.darkMode),
                  NavigationSubItem(title: 'Figma', value: Pages1.figma),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const AppDivider(isDashed: true),
            const SizedBox(height: 10),
            AppSidebarNavigationItem<Pages2>(
              style: SidebarNavigationItemStyle.nuetral,
              selectedItem: _selectedPage2,
              isItemExpanded: _isFoundationsExpanded,
              onItemSelected: (value) {
                setState(() {
                  _selectedPage2 = value;
                });
              },
              onItemExpansionChanged: (page, isExpanded) {
                setState(() {
                  _isFoundationsExpanded = isExpanded;
                });
              },
              item: NavigationItem<Pages2>(
                title: 'Foundations',
                value: Pages2.foundations,
                subItems: [
                  NavigationSubItem(
                    title: 'Typography',
                    value: Pages2.typography,
                  ),
                  NavigationSubItem(title: 'Colors', value: Pages2.colors),
                  NavigationSubItem(title: 'Radius', value: Pages2.radius),
                  NavigationSubItem(title: 'Spacing', value: Pages2.spacing),
                  NavigationSubItem(
                    title: 'Shadow Style',
                    value: Pages2.shadowStyle,
                  ),
                  NavigationSubItem(
                    title: 'Blur Style',
                    value: Pages2.blurStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
