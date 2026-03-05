import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/parking_order_sort_field.dart';
import 'package:admin_frontend/core/enums/parking_order_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_list/data/graphql/parking_order_list.graphql.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_list/presentation/blocs/parking_order_list.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ParkingOrderListTable extends StatelessWidget {
  const ParkingOrderListTable({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ParkingOrderListBloc>();
    return BlocBuilder<ParkingOrderListBloc, ParkingOrderListState>(
      builder: (context, state) {
        return AppDataTable(
          searchBarOptions: TableSearchBarOptions(enabled: false),
          columns: [
            DataColumn2(
              label: Text(
                context.tr.id,
                style: context.textTheme.labelMedium?.variant(context),
              ),
              fixedWidth: 70,
            ),
            DataColumn2(
              label: Text(
                context.tr.customer,
                style: context.textTheme.labelMedium?.variant(context),
              ),
              size: ColumnSize.L,
            ),
            DataColumn2(
              label: Text(
                context.tr.shop,
                style: context.textTheme.labelMedium?.variant(context),
              ),
              size: ColumnSize.L,
            ),
            DataColumn(
              label: Text(
                context.tr.dateAndTime,
                style: context.textTheme.labelMedium?.variant(context),
              ),
            ),
            DataColumn2(
              label: Text(
                context.tr.price,
                style: context.textTheme.labelMedium?.variant(context),
              ),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text(
                context.tr.status,
                style: context.textTheme.labelMedium?.variant(context),
              ),
            ),
          ],
          sortOptions: AppSortDropdown<Input$ParkOrderSort>(
            selectedValues: state.sorting,
            onChanged: bloc.onSortingChanged,
            items: [
              Input$ParkOrderSort(
                field: Enum$ParkOrderSortFields.id,
                direction: Enum$SortDirection.ASC,
              ),
              Input$ParkOrderSort(
                field: Enum$ParkOrderSortFields.id,
                direction: Enum$SortDirection.DESC,
              ),
              Input$ParkOrderSort(
                field: Enum$ParkOrderSortFields.paymentMode,
                direction: Enum$SortDirection.ASC,
              ),
              Input$ParkOrderSort(
                field: Enum$ParkOrderSortFields.paymentMode,
                direction: Enum$SortDirection.DESC,
              ),
              Input$ParkOrderSort(
                field: Enum$ParkOrderSortFields.status,
                direction: Enum$SortDirection.ASC,
              ),
              Input$ParkOrderSort(
                field: Enum$ParkOrderSortFields.status,
                direction: Enum$SortDirection.DESC,
              ),
            ],
            labelGetter: (item) =>
                item.field.tableViewSortLabel(context, item.direction),
          ),
          filterOptions: [
            AppFilterDropdown<Enum$ParkOrderStatus>(
              title: context.tr.status,
              selectedValues: state.parkingOrderStatus,
              onChanged: bloc.onStatusFilterChanged,
              items: Enum$ParkOrderStatus.values
                  .where((e) => e != Enum$ParkOrderStatus.$unknown)
                  .map(
                    (status) =>
                        FilterItem(label: status.name(context), value: status),
                  )
                  .toList(),
            ),
          ],
          getRowCount: (data) => data.parkOrders.nodes.length,
          rowBuilder: (data, int index) =>
              rowBuilder(context, state.parkingOrderState.data!, index),
          getPageInfo: (data) => data.parkOrders.pageInfo,
          data: state.parkingOrderState,
          paging: state.paging,
          onPageChanged: bloc.onPageChanged,
        );
      },
    );
  }
}

DataRow rowBuilder(
  BuildContext context,
  Query$parkingOrderList data,
  int index,
) {
  final parkOrder = data.parkOrders.nodes[index];
  return DataRow(
    onSelectChanged: (value) {
      context.router.push(
        ParkingOrderDetailRoute(parkingOrderId: parkOrder.id),
      );
    },
    cells: [
      DataCell(
        Text(
          '#${parkOrder.id}',
          style: context.textTheme.labelMedium?.variant(context),
        ),
      ),
      DataCell(
        parkOrder.carOwner?.tableView(context) ?? const SizedBox.shrink(),
      ),
      DataCell(parkOrder.parkSpot.tableView(context)),
      DataCell(
        Text(
          parkOrder.createdAt.formatDateTime,
          style: context.textTheme.labelMedium,
        ),
      ),
      DataCell(parkOrder.price.toCurrency(context, parkOrder.currency)),
      DataCell(parkOrder.status.toChip(context)),
    ],
  );
}
