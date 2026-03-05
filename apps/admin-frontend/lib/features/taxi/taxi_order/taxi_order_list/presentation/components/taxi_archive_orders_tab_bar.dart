import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/presentation/blocs/taxi_orders_archive_list.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:better_design_system/atoms/map_pin/rod_marker.dart';
import 'package:better_design_system/atoms/tab_menu_horizontal/tab_menu_horizontal.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:better_localization/localizations.dart';

class ArchiveOrdersTabBar extends StatefulWidget {
  const ArchiveOrdersTabBar({super.key});

  @override
  createState() => _ArchiveOrdersTabBarState();
}

class _ArchiveOrdersTabBarState extends State<ArchiveOrdersTabBar>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxiOrdersArchiveListBloc, TaxiOrdersArchiveListState>(
      builder: (context, state) {
        return AppTabMenuHorizontal<Enum$TaxiOrderStatus?>(
          selectedValue: state.statusFilter.firstOrNull,
          style: TabMenuHorizontalStyle.soft,
          color: SemanticColor.neutral,
          onChanged: context
              .read<TaxiOrdersArchiveListBloc>()
              .onStatusFilterChanged,
          tabs: [
            TabMenuHorizontalOption(title: context.tr.allOrders, value: null),
            TabMenuHorizontalOption(
              title: context.tr.completed,
              value: Enum$TaxiOrderStatus.Completed,
            ),
            TabMenuHorizontalOption(
              title: context.tr.canceled,
              value: Enum$TaxiOrderStatus.Canceled,
            ),
            TabMenuHorizontalOption(
              title: context.tr.expired,
              value: Enum$TaxiOrderStatus.Expired,
            ),
          ],
        );
      },
    );
  }
}
