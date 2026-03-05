import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/molecules/kpi_card/number_stat_card/number_stat_card.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/enums/app_color_scheme.enum.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/platform_overview/presentation/blocs/platform_overview.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class PlatformOverviewTopStatCards extends StatelessWidget {
  const PlatformOverviewTopStatCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlatformOverviewCubit, PlatformOverviewState>(
      builder: (context, state) {
        return BlocBuilder<ConfigBloc, ConfigState>(
          builder: (context, stateConfig) {
            return Skeletonizer(
              enabled: state.overviewKPIs.isLoading,
              enableSwitchAnimation: true,
              child: LayoutGrid(
                columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr, 1.fr]),
                rowGap: 8,
                columnGap: 8,
                rowSizes: context.isDesktop ? const [auto] : [auto, auto, auto],
                children: [
                  AppNumberStatCard(
                    title: context.tr.totalOrders,
                    icon: BetterIcons.dashboardSpeed02Filled,
                    percent:
                        state
                            .overviewKPIs
                            .data
                            ?.platformKPI
                            .totalOrders
                            .change ??
                        0,
                    totalNumber: state
                        .overviewKPIs
                        .data
                        ?.platformKPI
                        .totalOrders
                        .total
                        .toStringAsFixed(0),
                    options: [
                      if (stateConfig.config.data?.config?.taxi != null)
                        NumberStatCardOption(
                          title: context.tr.taxi,
                          color:
                              stateConfig
                                  .appConfig(Enum$AppType.Taxi)
                                  .color
                                  ?.toBrandColor
                                  .colors
                                  .firstOrNull ??
                              Colors.red,
                          value: state.overviewKPIs.isLoading
                              ? 0
                              : (state
                                        .overviewKPIs
                                        .data
                                        ?.platformKPI
                                        .totalOrders
                                        .breakdown
                                        .firstWhereOrNull(
                                          (e) => e.app == Enum$AppType.Taxi,
                                        )
                                        ?.value ??
                                    0),
                        ),
                      if (stateConfig.config.data?.config?.shop != null)
                        NumberStatCardOption(
                          title: context.tr.shop,
                          color:
                              stateConfig
                                  .appConfig(Enum$AppType.Shop)
                                  .color
                                  ?.toBrandColor
                                  .colors
                                  .firstOrNull ??
                              Colors.red,
                          value: state.overviewKPIs.isLoading
                              ? 0
                              : (state
                                        .overviewKPIs
                                        .data
                                        ?.platformKPI
                                        .totalOrders
                                        .breakdown
                                        .firstWhereOrNull(
                                          (e) => e.app == Enum$AppType.Shop,
                                        )
                                        ?.value ??
                                    0),
                        ),
                      if (stateConfig.config.data?.config?.parking != null)
                        NumberStatCardOption(
                          title: context.tr.parking,
                          color:
                              stateConfig
                                  .appConfig(Enum$AppType.Parking)
                                  .color
                                  ?.toBrandColor
                                  .colors
                                  .firstOrNull ??
                              Colors.red,
                          value: state.overviewKPIs.isLoading
                              ? 0
                              : (state
                                        .overviewKPIs
                                        .data
                                        ?.platformKPI
                                        .totalOrders
                                        .breakdown
                                        .firstWhereOrNull(
                                          (e) => e.app == Enum$AppType.Parking,
                                        )
                                        ?.value ??
                                    0),
                        ),
                    ],
                  ),
                  AppNumberStatCard(
                    title: context.tr.totalRevenue,
                    icon: BetterIcons.coins01Filled,
                    totalNumber:
                        (state
                                    .overviewKPIs
                                    .data
                                    ?.platformKPI
                                    .totalRevenue
                                    .total ??
                                0)
                            .formatCurrency(state.currency),
                    percent:
                        state
                            .overviewKPIs
                            .data
                            ?.platformKPI
                            .totalRevenue
                            .change ??
                        0,
                    options: [
                      if (stateConfig.config.data?.config?.taxi != null)
                        NumberStatCardOption(
                          title: context.tr.taxi,
                          color:
                              stateConfig
                                  .appConfig(Enum$AppType.Taxi)
                                  .color
                                  ?.toBrandColor
                                  .colors
                                  .firstOrNull ??
                              Colors.red,
                          value:
                              state
                                  .overviewKPIs
                                  .data
                                  ?.platformKPI
                                  .totalRevenue
                                  .breakdown
                                  .firstWhereOrNull(
                                    (e) => e.app == Enum$AppType.Taxi,
                                  )
                                  ?.value ??
                              0,
                        ),
                      if (stateConfig.config.data?.config?.shop != null)
                        NumberStatCardOption(
                          title: context.tr.shop,
                          color:
                              stateConfig
                                  .appConfig(Enum$AppType.Shop)
                                  .color
                                  ?.toBrandColor
                                  .colors
                                  .firstOrNull ??
                              Colors.red,
                          value:
                              state
                                  .overviewKPIs
                                  .data
                                  ?.platformKPI
                                  .totalRevenue
                                  .breakdown
                                  .firstWhereOrNull(
                                    (e) => e.app == Enum$AppType.Shop,
                                  )
                                  ?.value ??
                              0,
                        ),
                      if (stateConfig.config.data?.config?.parking != null)
                        NumberStatCardOption(
                          title: context.tr.parking,
                          color:
                              stateConfig
                                  .appConfig(Enum$AppType.Parking)
                                  .color
                                  ?.toBrandColor
                                  .colors
                                  .firstOrNull ??
                              Colors.red,
                          value:
                              state
                                  .overviewKPIs
                                  .data
                                  ?.platformKPI
                                  .totalRevenue
                                  .breakdown
                                  .firstWhereOrNull(
                                    (e) => e.app == Enum$AppType.Parking,
                                  )
                                  ?.value ??
                              0,
                        ),
                    ],
                  ),
                  AppNumberStatCard(
                    title: context.tr.activeCustomers,
                    icon: BetterIcons.userGroup03Filled,
                    totalNumber: state
                        .overviewKPIs
                        .data
                        ?.platformKPI
                        .activeCustomers
                        .total
                        .toStringAsFixed(0),
                    percent:
                        state
                            .overviewKPIs
                            .data
                            ?.platformKPI
                            .activeCustomers
                            .change ??
                        0,
                    options: [
                      if (stateConfig.config.data?.config?.taxi != null)
                        NumberStatCardOption(
                          title: context.tr.taxi,
                          color:
                              stateConfig
                                  .appConfig(Enum$AppType.Taxi)
                                  .color
                                  ?.toBrandColor
                                  .colors
                                  .firstOrNull ??
                              Colors.red,
                          value: state.overviewKPIs.isLoading
                              ? 0
                              : (state
                                        .overviewKPIs
                                        .data
                                        ?.platformKPI
                                        .activeCustomers
                                        .breakdown
                                        .firstWhereOrNull(
                                          (e) => e.app == Enum$AppType.Taxi,
                                        )
                                        ?.value ??
                                    0),
                        ),
                      if (stateConfig.config.data?.config?.shop != null)
                        NumberStatCardOption(
                          title: context.tr.shop,
                          color:
                              stateConfig
                                  .appConfig(Enum$AppType.Shop)
                                  .color
                                  ?.toBrandColor
                                  .colors
                                  .firstOrNull ??
                              Colors.red,
                          value: state.overviewKPIs.isLoading
                              ? 0
                              : (state
                                        .overviewKPIs
                                        .data
                                        ?.platformKPI
                                        .activeCustomers
                                        .breakdown
                                        .firstWhereOrNull(
                                          (e) => e.app == Enum$AppType.Shop,
                                        )
                                        ?.value ??
                                    0),
                        ),
                      if (stateConfig.config.data?.config?.parking != null)
                        NumberStatCardOption(
                          title: context.tr.parking,
                          color:
                              stateConfig
                                  .appConfig(Enum$AppType.Parking)
                                  .color
                                  ?.toBrandColor
                                  .colors
                                  .firstOrNull ??
                              Colors.red,
                          value: state.overviewKPIs.isLoading
                              ? 0
                              : (state
                                        .overviewKPIs
                                        .data
                                        ?.platformKPI
                                        .activeCustomers
                                        .breakdown
                                        .firstWhereOrNull(
                                          (e) => e.app == Enum$AppType.Parking,
                                        )
                                        ?.value ??
                                    0),
                        ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
