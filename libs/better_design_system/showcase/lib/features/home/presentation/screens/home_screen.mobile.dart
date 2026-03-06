part of 'home_screen.dart';

class HomeScreenMobile extends StatefulWidget {
  const HomeScreenMobile({super.key});

  @override
  State<HomeScreenMobile> createState() => _HomeScreenMobileState();
}

class _HomeScreenMobileState extends State<HomeScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Padding(
                    padding: const EdgeInsets.fromLTRB(16, 40, 16, 24),
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
                                style: context.textTheme.labelMedium?.copyWith(
                                  color: context.colors.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Design Your App’s Mood in a Snap',
                          style: context.textTheme.displayMedium,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '8 ready-to-use themes, each crafted to match your application’s vibe. From vibrant to minimal, light to dark.',
                          style: context.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fade(delay: 300.ms)
                  .slideY(curve: Curves.easeIn, begin: -0.5),
              const HorizontalThemeTabBar()
                  .animate()
                  .fade(delay: 300.ms)
                  .slideY(curve: Curves.easeIn, begin: 0.5),
              const SizedBox(height: 24),
              Column(
                spacing: 24,
                children: [
                  AppSpendingSummary(),

                  AppNotificationCard(),

                  AppPricingPlans(),

                  AppUserPost(),

                  AppUserAccess(),

                  AppLoginOtp(),

                  AppOnboardingCalendar(),

                  AppExchange(),

                  AppEmailVerification(),

                  AppNewAccount(),
                  AppTimeTracker(),
                  AppMessageList(),
                  AppSavedActions(),
                  AppNewCustomers(),
                  AppNotificationSetting(),
                  AppComponentDoc(),
                ],
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
