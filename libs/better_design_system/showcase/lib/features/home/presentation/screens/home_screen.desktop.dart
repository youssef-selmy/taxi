part of 'home_screen.dart';

class HomeScreenDesktop extends StatefulWidget {
  const HomeScreenDesktop({super.key});

  @override
  State<HomeScreenDesktop> createState() => _HomeScreenDesktopState();
}

class _HomeScreenDesktopState extends State<HomeScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                        padding: const EdgeInsets.fromLTRB(108, 40, 108, 48),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: context.colors.outline,
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Themes',
                                    style: context.textTheme.labelMedium
                                        ?.copyWith(
                                          color:
                                              context.colors.onSurfaceVariant,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: 484,
                              child: Column(
                                children: [
                                  Text(
                                    'Design Your App’s Mood in a Snap',
                                    style: context.textTheme.displayLarge,
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '8 ready-to-use themes, each crafted to match your application’s vibe. From vibrant to minimal, light to dark.',
                                    style: context.textTheme.bodyMedium,
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fade(delay: 300.ms)
                      .slideY(curve: Curves.easeIn, begin: -0.5),
                  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 108),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Center(child: HorizontalThemeTabBar()),
                            ),
                            BlocBuilder<SettingsCubit, SettingsState>(
                              builder: (context, state) {
                                return AppToggleSwitchButtonGroup<ThemeMode>(
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
                                  selectedValue: state.themeMode,
                                  onChanged: (ThemeMode value) {
                                    context
                                        .read<SettingsCubit>()
                                        .changeThemeMode(value);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fade(delay: 300.ms)
                      .slideY(curve: Curves.easeIn, begin: 0.5),
                ],
              ),
              const SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 108),
                child: StaggeredGrid.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: AppSpendingSummary(),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: AppLoginOtp(),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: AppTimeTracker(),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: AppMessageList(),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: AppNotificationCard(),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: AppOnboardingCalendar(),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: AppSavedActions(),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: AppPricingPlans(),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: AppExchange(),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: AppNewCustomers(),
                    ),

                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: AppUserPost(),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: AppEmailVerification(),
                    ),

                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: AppUserAccess(),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: AppNotificationSetting(),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: AppNewAccount(),
                    ),
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: AppComponentDoc(),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 700.ms, curve: Curves.easeIn),
              const SizedBox(height: 40),
              AppFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
