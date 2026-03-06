part of 'fintech_screen.dart';

class FintechScreenMobile extends StatelessWidget {
  const FintechScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<NavigatorCubit>(),
      child: Scaffold(
        backgroundColor: context.colors.surfaceVariantLow,
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400, maxHeight: 1000),
            child: BlocBuilder<NavigatorCubit, AppNavigatorState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      Expanded(child: AutoRouter()),

                      if (state.selectedRoute == FintechHomeRoute() ||
                          state.selectedRoute == FintechCardRoute() ||
                          state.selectedRoute == FintechAnalyticsRoute() ||
                          state.selectedRoute == FintechProfileRoute())
                        ClipRRect(
                          borderRadius: BorderRadiusGeometry.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          child: AppBottomNavigation<PageRouteInfo>(
                            primaryActionPosition:
                                PrimaryActionPosition.floating,
                            primaryAction: BottomNavFab(
                              color: SemanticColor.primary,
                              icon: Icon(
                                BetterIcons.add01Outline,
                                size: 24,
                                color: context.colors.surface,
                              ),
                              onPressed: () {
                                context
                                    .read<NavigatorCubit>()
                                    .onNavigationItemTapped(
                                      FintechTransferRoute(),
                                    );
                                context.router.replaceAll([
                                  FintechTransferRoute(),
                                ]);
                              },
                            ),
                            onTap: (value) {
                              context
                                  .read<NavigatorCubit>()
                                  .onNavigationItemTapped(value);
                              context.router.replaceAll([value]);
                            },
                            selectedValue: state.selectedRoute,
                            items: [
                              NavigationItem(
                                label: 'Home',
                                icon: Icon(BetterIcons.home01Outline),
                                activeIcon: Icon(BetterIcons.home01Filled),
                                value: FintechHomeRoute(),
                              ),
                              NavigationItem(
                                label: 'Card',
                                icon: Icon(BetterIcons.creditCardOutline),
                                activeIcon: Icon(BetterIcons.creditCardFilled),
                                value: FintechCardRoute(),
                              ),

                              NavigationItem(
                                label: 'Analytics',
                                icon: Icon(BetterIcons.analytics01Outline),
                                activeIcon: Icon(BetterIcons.analytics01Filled),
                                value: FintechAnalyticsRoute(),
                              ),
                              NavigationItem(
                                label: 'Profile',
                                icon: Icon(BetterIcons.userCircle02Outline),
                                activeIcon: Icon(
                                  BetterIcons.userCircle02Filled,
                                ),
                                value: FintechProfileRoute(),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
