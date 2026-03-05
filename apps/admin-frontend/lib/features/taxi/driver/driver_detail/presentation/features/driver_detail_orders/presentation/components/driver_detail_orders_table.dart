import 'package:admin_frontend/core/graphql/documents/taxi_orders.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_method.extensions.dart';
import 'package:better_design_system/molecules/table_cells/profile_cell.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/taxi_order_sort_field.dart';
import 'package:admin_frontend/core/enums/taxi_order_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_orders/presentation/blocs/driver_detail_orders.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverDetailOrdersTable extends StatefulWidget {
  const DriverDetailOrdersTable({super.key});

  @override
  State<DriverDetailOrdersTable> createState() =>
      _DriverDetailOrdersTableState();
}

class _DriverDetailOrdersTableState extends State<DriverDetailOrdersTable> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverDetailOrdersBloc>();
    return BlocBuilder<DriverDetailOrdersBloc, DriverDetailOrdersState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.tr.ordersList, style: context.textTheme.bodyMedium),
            const SizedBox(height: 16),
            Expanded(
              child: AppDataTable(
                columns: [
                  DataColumn2(
                    label: Text(context.tr.driver),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text(context.tr.dateAndTime),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(label: Text(context.tr.cost), size: ColumnSize.S),
                  DataColumn2(
                    label: Text(context.tr.paymentMethod),
                    size: ColumnSize.L,
                  ),
                  // DataColumn2(
                  //   label: Text(
                  //     context.translate.location,
                  //   ),
                  //   size: ColumnSize.L,
                  // ),
                  DataColumn2(
                    label: Text(context.tr.status),
                    size: ColumnSize.M,
                  ),
                ],
                sortOptions: AppSortDropdown<Input$OrderSort>(
                  selectedValues: state.sorting,
                  onChanged: (value) {
                    bloc.onSortingChanged(value);
                  },
                  items: [
                    Input$OrderSort(
                      field: Enum$OrderSortFields.id,
                      direction: Enum$SortDirection.ASC,
                    ),
                    Input$OrderSort(
                      field: Enum$OrderSortFields.id,
                      direction: Enum$SortDirection.DESC,
                    ),
                    Input$OrderSort(
                      field: Enum$OrderSortFields.createdOn,
                      direction: Enum$SortDirection.ASC,
                    ),
                    Input$OrderSort(
                      field: Enum$OrderSortFields.createdOn,
                      direction: Enum$SortDirection.DESC,
                    ),
                  ],
                  labelGetter: (item) =>
                      item.field.tableViewSortLabel(context, item.direction),
                ),
                filterOptions: [
                  AppFilterDropdown<Enum$TaxiOrderStatus>(
                    title: context.tr.status,

                    selectedValues: state.driverOrderStatusFilter,
                    onChanged: bloc.onStatusFilterChanged,
                    items: Enum$TaxiOrderStatus.values.toFilterItems(context),
                  ),
                ],
                getRowCount: (data) => data.taxiOrders.edges.length,
                rowBuilder: (Query$taxiOrders data, int index) =>
                    rowBuilder(context, data, index),
                getPageInfo: (data) => data.taxiOrders.pageInfo.offsetPageInfo,
                data: state.driverOrdersState,
                paging: state.paging,
                onPageChanged: bloc.onPageChanged,
              ),
            ),
            SizedBox(height: 24),
          ],
        );
      },
    );
  }
}

DataRow rowBuilder(BuildContext context, Query$taxiOrders data, int index) {
  final driverOrder = data.taxiOrders.edges[index];
  return DataRow(
    onSelectChanged: (value) {
      context.router.navigate(
        TaxiShellRoute(
          children: [
            TaxiOrderShellRoute(
              children: [TaxiOrderDetailRoute(orderId: driverOrder.id)],
            ),
          ],
        ),
      );
    },
    cells: [
      DataCell(
        AppProfileCell(
          name: driverOrder.rider.fullName ?? "N/A",
          imageUrl: driverOrder.rider.imageUrl,
        ),
      ),
      DataCell(
        Text(
          driverOrder.createdAt.formatDateTime,
          style: context.textTheme.labelMedium,
        ),
      ),
      DataCell(driverOrder.totalCost.toCurrency(context, driverOrder.currency)),
      DataCell(driverOrder.paymentMethod.tableViewPaymentMethod(context)),
      DataCell(driverOrder.status.chip(context)),
    ],
  );
}
