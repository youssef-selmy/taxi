import 'package:admin_frontend/core/graphql/documents/taxi_orders.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/presentation/blocs/taxi_orders_archive_list.cubit.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/presentation/components/taxi_archive_orders_tab_bar.dart';
import 'package:better_design_system/atoms/clickable_card/clickable_card.dart';
import 'package:better_design_system/molecules/table_cells/profile_cell.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/taxi_order_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/router/app_router.dart';

class ArchiveOrdersTable extends StatelessWidget {
  const ArchiveOrdersTable({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaxiOrdersArchiveListBloc>();
    return BlocBuilder<TaxiOrdersArchiveListBloc, TaxiOrdersArchiveListState>(
      builder: (context, state) {
        return SafeArea(
          top: false,
          child: AppClickableCard(
            type: ClickableCardType.elevated,
            elevation: BetterShadow.shadow8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const ArchiveOrdersTabBar(),
                const SizedBox(height: 16),
                Expanded(
                  child: AppDataTable(
                    minWidth: 1100,
                    searchBarOptions: TableSearchBarOptions(enabled: false),
                    columns: [
                      DataColumn2(label: Text(context.tr.id), fixedWidth: 70),
                      DataColumn2(
                        label: Text(context.tr.customer),
                        size: ColumnSize.L,
                      ),
                      DataColumn2(
                        label: Text(context.tr.driver),
                        size: ColumnSize.L,
                      ),
                      DataColumn(label: Text(context.tr.dateAndTime)),
                      DataColumn(label: Text(context.tr.price)),
                      DataColumn(label: Text(context.tr.status)),
                    ],
                    filterOptions: [
                      AppFilterDropdown<Fragment$fleetListItem>(
                        title: context.tr.fleets,
                        selectedValues: state.fleetFilterList,
                        onChanged: bloc.onFleetFilterChanged,
                        items:
                            state.fleets.data?.fleets.nodes
                                .map(
                                  (fleet) => FilterItem(
                                    label: fleet.name,
                                    value: fleet,
                                  ),
                                )
                                .toList() ??
                            [],
                      ),
                    ],
                    getRowCount: (data) => data.taxiOrders.edges.length,
                    rowBuilder: (data, int index) =>
                        rowBuilder(context, data, index),
                    getPageInfo: (data) =>
                        data.taxiOrders.pageInfo.offsetPageInfo,
                    data: state.ordersList,
                    paging: state.paging,
                    onPageChanged: bloc.onPageChanged,
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

DataRow rowBuilder(BuildContext context, Query$taxiOrders data, int index) {
  final order = data.taxiOrders.edges[index];
  return DataRow(
    onSelectChanged: (value) {
      context.router.navigate(
        TaxiShellRoute(
          children: [
            TaxiOrderShellRoute(
              children: [TaxiOrderDetailRoute(orderId: order.id)],
            ),
          ],
        ),
      );
    },
    cells: [
      DataCell(
        Text(
          '#${order.id}',
          style: context.textTheme.labelMedium?.variant(context),
        ),
      ),
      DataCell(
        AppProfileCell(
          name: order.rider.fullName ?? "N/A",
          imageUrl: order.rider.imageUrl,
          subtitle: order.rider.mobileNumber.formatPhoneNumber(null),
        ),
      ),
      DataCell(
        AppProfileCell(
          name: order.driver?.fullName ?? context.tr.searching,
          imageUrl: order.driver?.imageUrl,
          subtitle: order.driver?.mobileNumber.formatPhoneNumber(null),
        ),
      ),
      DataCell(
        Text(
          order.createdAt.formatDateTime,
          style: context.textTheme.labelMedium,
        ),
      ),
      DataCell(order.totalCost.toCurrency(context, order.currency)),
      DataCell(order.status.chip(context)),
    ],
  );
}
