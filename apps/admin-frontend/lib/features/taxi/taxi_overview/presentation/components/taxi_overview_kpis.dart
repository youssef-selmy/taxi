import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/components/kpi_card/kpi_card_style_a.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/dashboard/presentation/blocs/dashboard.cubit.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/presentation/blocs/taxi_overview.bloc.dart';
import 'package:better_icons/better_icons.dart';

class TaxiOverviewKPIs extends StatelessWidget {
  const TaxiOverviewKPIs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxiOverviewBloc, TaxiOverviewState>(
      builder: (context, state) {
        return LayoutGrid(
          columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr, 1.fr, 1.fr]),
          rowSizes: List.generate(
            context.responsive(4, lg: 1),
            (index) => auto,
          ),
          rowGap: 8,
          columnGap: 8,
          children: [
            KPICardStyleA(
              title: context.tr.totalOrders,
              iconData: BetterIcons.car05Filled,
              value:
                  state.kpisState.data?.totalOrders.totalCount.toString() ??
                  "0",
              onSeeMore: () {
                context.read<DashboardBloc>().goToRoute(TaxiOrderShellRoute());
                context.router.replaceAll([
                  TaxiOrderShellRoute(children: [TaxiOrderListRoute()]),
                ]);
              },
            ),
            KPICardStyleA(
              title: context.tr.totalRevenue,
              iconData: BetterIcons.money03Filled,
              value:
                  (state
                              .kpisState
                              .data
                              ?.totalRevenue
                              .firstOrNull
                              ?.sum
                              ?.amount ??
                          0)
                      .formatCurrency(state.currency ?? Env.defaultCurrency),
              onSeeMore: () {
                context.read<DashboardBloc>().goToRoute(AccountingShellRoute());
                context.router.navigate(
                  AccountingShellRoute(
                    children: [
                      AdminAccountingShellRoute(
                        children: [AdminAccountingDashboardRoute()],
                      ),
                    ],
                  ),
                );
              },
            ),
            KPICardStyleA(
              title: context.tr.activeDrivers,
              iconData: BetterIcons.taxiFilled,
              value:
                  state.kpisState.data?.totalDrivers.totalCount.toString() ??
                  "0",
              onSeeMore: () {
                context.read<DashboardBloc>().goToRoute(DriverShellRoute());
                context.router.replaceAll([
                  DriverShellRoute(children: [DriverListRoute()]),
                ]);
              },
            ),
            KPICardStyleA(
              title: context.tr.activeCustomers,
              iconData: BetterIcons.car05Filled,
              value:
                  state.kpisState.data?.totalCustomers.totalCount.toString() ??
                  "0",
              onSeeMore: () {
                context.read<DashboardBloc>().goToRoute(CustomerShellRoute());
                context.router.replaceAll([
                  CustomerShellRoute(children: [CustomersRoute()]),
                ]);
              },
            ),
          ],
        );
      },
    );
  }
}
