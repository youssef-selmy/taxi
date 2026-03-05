import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/platform_overview/presentation/blocs/platform_overview.cubit.dart';
import 'package:admin_frontend/features/platform_overview/presentation/components/platform_overview_parking_table.dart';
import 'package:admin_frontend/features/platform_overview/presentation/components/platform_overview_shop_table.dart';
import 'package:admin_frontend/features/platform_overview/presentation/components/platform_overview_taxi_table.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:better_icons/better_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlatformOverviewTable extends StatefulWidget {
  const PlatformOverviewTable({super.key});

  @override
  State<PlatformOverviewTable> createState() => _PlatformOverviewTableState();
}

class _PlatformOverviewTableState extends State<PlatformOverviewTable> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlatformOverviewCubit, PlatformOverviewState>(
      builder: (context, state) {
        return SafeArea(
          top: false,
          child: Container(
            decoration: BoxDecoration(
              color: context.colors.surface,
              border: Border.all(color: context.colors.outline),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: context.colors.shadow,
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                  spreadRadius: -4,
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 16,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  spacing: 16,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        context.tr.recentOrders,
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                    AppToggleSwitchButtonGroup(
                      options: [
                        ToggleSwitchButtonGroupOption(
                          value: Enum$AppType.Taxi,
                          icon: BetterIcons.taxiOutline,
                          label: context.tr.taxi,
                          selectedIcon: BetterIcons.taxiFilled,
                        ),
                        ToggleSwitchButtonGroupOption(
                          value: Enum$AppType.Shop,
                          icon: BetterIcons.store01Outline,
                          label: context.tr.shop,
                          selectedIcon: BetterIcons.store01Filled,
                        ),
                        ToggleSwitchButtonGroupOption(
                          value: Enum$AppType.Parking,
                          icon: BetterIcons.parkingAreaSquareOutline,
                          label: context.tr.parking,
                          selectedIcon: BetterIcons.parkingAreaSquareFilled,
                        ),
                      ],
                      onChanged: (value) {
                        switch (value) {
                          case Enum$AppType.Taxi:
                            _pageController.jumpToPage(0);
                          case Enum$AppType.Shop:
                            context
                                .read<PlatformOverviewCubit>()
                                .fetchShopOrders();
                            _pageController.jumpToPage(1);

                          case Enum$AppType.Parking:
                            context
                                .read<PlatformOverviewCubit>()
                                .fetchParkingOrders();
                            _pageController.jumpToPage(2);
                          case Enum$AppType.$unknown:
                            _pageController.jumpToPage(0);
                        }
                        context
                            .read<PlatformOverviewCubit>()
                            .onSelectedCategoryChanged(value);
                      },
                      selectedValue: state.selectedCategory,
                    ),
                    if (context.isDesktop)
                      AppFilledButton(
                        onPressed: () async {
                          locator<AuthBloc>().add(
                            AuthEvent.changeAppType(state.selectedCategory),
                          );
                          switch (state.selectedCategory) {
                            case Enum$AppType.Taxi:
                              context.router.navigate(
                                TaxiShellRoute(
                                  children: [DispatcherTaxiRoute()],
                                ),
                              );
                              break;
                            case Enum$AppType.Shop:
                              context.router.navigate(
                                ShopShellRoute(
                                  children: [ShopDispatcherRoute()],
                                ),
                              );
                              break;
                            case Enum$AppType.Parking:
                              context.router.navigate(
                                ParkingShellRoute(
                                  children: [ParkingDispatcherRoute()],
                                ),
                              );
                              break;
                            case Enum$AppType.$unknown:
                              break;
                          }
                        },
                        prefixIcon: BetterIcons.rocket01Outline,
                        text: context.tr.dispatchAnOrder,
                      ),
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    children: [
                      PlatformOverviewTaxiTable(),
                      PlatformOverviewShopTable(),
                      PlatformOverviewParkingTable(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
