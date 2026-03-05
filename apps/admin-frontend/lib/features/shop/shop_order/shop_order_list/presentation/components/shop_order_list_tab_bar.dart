import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/tab_bar/tab_bar.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_list/presentation/blocs/shop_order_list.cubit.dart';
import 'package:better_localization/localizations.dart';

class ShopOrderListTabBar extends StatefulWidget {
  const ShopOrderListTabBar({super.key});

  @override
  State<ShopOrderListTabBar> createState() => _ShopOrderListTabBarState();
}

class _ShopOrderListTabBarState extends State<ShopOrderListTabBar>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopOrderListBloc, ShopOrderListState>(
      builder: (context, state) {
        return AppTabBar(
          onTabChanged: (value) {
            context.read<ShopOrderListBloc>().onTabChangedFilter(value);
          },
          tabController: _tabController,
          isCompact: true,
          tabs: [
            AppTabItem(
              title: "${context.tr.allOrders} (${state.totalShopOrdersCount})",
            ),
            AppTabItem(
              title: "${context.tr.pending} (${state.pendingShopOrdersCount})",
            ),
            AppTabItem(
              title: "${context.tr.shipping} (${state.sentShopOrdersCount})",
            ),
            AppTabItem(
              title:
                  "${context.tr.delivered} (${state.completedShopOrdersCount})",
            ),
            AppTabItem(
              title: "${context.tr.canceled} (${state.errorShopOrdersCount})",
            ),
            AppTabItem(
              title: "${context.tr.onHold} (${state.onHoldShopOrdersCount})",
            ),
          ],
        );
      },
    );
  }
}
