import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/components/kpi_card/kpi_card_style_a.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/shop/shop_overview/presentation/blocs/shop_overview.bloc.dart';
import 'package:better_icons/better_icons.dart';

class ShopOverviewKPIs extends StatelessWidget {
  const ShopOverviewKPIs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopOverviewBloc, ShopOverviewState>(
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
                context.router.push(ShopOrderListRoute());
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
                context.router.push(AdminAccountingDashboardRoute());
              },
            ),
            KPICardStyleA(
              title: context.tr.activeShops,
              iconData: BetterIcons.shoppingBag02Filled,
              value:
                  state.kpisState.data?.totalShops.totalCount.toString() ?? "0",
              onSeeMore: () {
                context.router.push(VendorListRoute());
              },
            ),
            KPICardStyleA(
              title: context.tr.activeCustomers,
              iconData: BetterIcons.car05Filled,
              value:
                  state.kpisState.data?.totalCustomers.totalCount.toString() ??
                  "0",
              onSeeMore: () {
                context.router.popAndPush(CustomerShellRoute());
              },
            ),
          ],
        );
      },
    );
  }
}
