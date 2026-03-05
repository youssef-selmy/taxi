import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/enums/parking_order_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/parking/parking_overview/presentation/blocs/parking_overview.bloc.dart';
import 'package:better_icons/better_icons.dart';

class ParkingOverviewActiveOrders extends StatelessWidget {
  const ParkingOverviewActiveOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ParkingOverviewBloc>();
    return BlocBuilder<ParkingOverviewBloc, ParkingOverviewState>(
      builder: (context, state) {
        return Column(
          children: [
            LargeHeader(
              title: context.tr.activeOrders,
              counter:
                  state.activeOrdersState.data?.activeOrders.totalCount ?? 0,
              actions: [
                AppOutlinedButton(
                  onPressed: () {
                    context.router.push(ParkingDispatcherRoute());
                  },
                  prefixIcon: BetterIcons.rocket01Filled,
                  text: context.tr.dispatchAnOrder,
                ),
                AppOutlinedButton(
                  onPressed: () {
                    context.router.push(ParkingOrderListRoute());
                  },
                  color: SemanticColor.neutral,
                  text: context.tr.viewAll,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 365,
              child: AppDataTable(
                columns: [
                  DataColumn2(label: Text(context.tr.id), fixedWidth: 70),
                  DataColumn(label: Text(context.tr.customer)),
                  DataColumn(label: Text(context.tr.parking)),
                  DataColumn2(
                    label: Text(context.tr.dateAndTime),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text(context.tr.price),
                    size: ColumnSize.S,
                  ),
                  DataColumn(label: Text(context.tr.status)),
                ],
                getRowCount: (data) => data.activeOrders.nodes.length,
                rowBuilder: (data, index) =>
                    _rowBuilder(context, data.activeOrders.nodes[index]),
                getPageInfo: (data) => data.activeOrders.pageInfo,
                data: state.activeOrdersState,
                onPageChanged: bloc.onActiveOrdersPageChanged,
                paging: state.activeOrdersPaging,
              ),
            ),
          ],
        );
      },
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Fragment$parkingOrderListItem node,
  ) {
    return DataRow(
      onSelectChanged: (value) {
        context.router.push(ParkingOrderDetailRoute(parkingOrderId: node.id));
      },
      cells: [
        DataCell(
          Text(
            "#${node.id}",
            style: context.textTheme.labelMedium?.variant(context),
          ),
        ),
        DataCell(node.carOwner?.tableView(context) ?? const SizedBox.shrink()),
        DataCell(node.parkSpot.tableView(context)),
        DataCell(
          Text(
            node.createdAt.formatDateTime,
            style: context.textTheme.labelMedium?.variant(context),
          ),
        ),
        DataCell(node.price.toCurrency(context, node.currency)),
        DataCell(node.status.toChip(context)),
      ],
    );
  }
}
