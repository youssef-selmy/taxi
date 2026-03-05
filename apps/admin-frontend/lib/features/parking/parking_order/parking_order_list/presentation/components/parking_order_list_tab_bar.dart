import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/tab_bar/tab_bar.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_list/presentation/blocs/parking_order_list.cubit.dart';

class ParkingOrderListTabBar extends StatefulWidget {
  const ParkingOrderListTabBar({super.key});

  @override
  State<ParkingOrderListTabBar> createState() => _ParkingOrderListTabBarState();
}

class _ParkingOrderListTabBarState extends State<ParkingOrderListTabBar>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 7, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkingOrderListBloc, ParkingOrderListState>(
      builder: (context, state) {
        return AppTabBar(
          onTabChanged: (value) {
            context.read<ParkingOrderListBloc>().onTabChangedFilter(value);
          },
          tabController: _tabController,
          isCompact: true,
          tabs: [
            AppTabItem(
              title:
                  "${context.tr.allOrders} (${state.totalParkingOrdersCount})",
            ),
            AppTabItem(
              title:
                  "${context.tr.accepted} (${state.accepteParkingOrdersCount})",
            ),
            AppTabItem(
              title:
                  "${context.tr.pending} (${state.pendingParkingOrdersCount})",
            ),
            AppTabItem(
              title: "${context.tr.paid} (${state.paidParkingOrdersCount})",
            ),
            AppTabItem(
              title:
                  "${context.tr.completed} (${state.completedParkingOrdersCount})",
            ),
            AppTabItem(
              title:
                  "${context.tr.rejected} (${state.rejectedParkingOrdersCount})",
            ),
            AppTabItem(
              title:
                  "${context.tr.canceled} (${state.canceleParkingOrdersCount})",
            ),
          ],
        );
      },
    );
  }
}
