import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/parking_order_sort_field.dart';
import 'package:admin_frontend/core/enums/parking_order_status.dart';
import 'package:admin_frontend/core/enums/payment_method.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/blocs/park_spot_detail_orders.cubit.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/screens/dialogs/park_spot_detail_order_detail_dialog.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ParkSpotDetailOrdersHistoryTab extends StatelessWidget {
  final String parkSpotId;

  const ParkSpotDetailOrdersHistoryTab({super.key, required this.parkSpotId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkSpotDetailOrdersBloc, ParkSpotDetailOrdersState>(
      builder: (context, state) {
        final bloc = context.read<ParkSpotDetailOrdersBloc>();
        return AppDataTable(
          title: context.tr.orderHistory,
          data: state.ordersHistoryState,
          getPageInfo: (data) => data.parkOrders.pageInfo,
          getRowCount: (data) => data.parkOrders.nodes.length,
          sortOptions: _buildSortOptions(context, state),
          filterOptions: [_buildStatusFilter(context, state)],
          paging: state.historyPaging,
          onPageChanged: bloc.onHistoryPageChanged,
          columns: [
            DataColumn2(label: Text(context.tr.id), fixedWidth: 60),
            DataColumn(label: Text(context.tr.customer)),
            DataColumn2(
              label: Text(context.tr.dateAndTime),
              size: ColumnSize.S,
            ),
            DataColumn2(label: Text(context.tr.total), size: ColumnSize.S),
            DataColumn(label: Text(context.tr.paymentMethod)),
            DataColumn2(label: Text(context.tr.status), size: ColumnSize.S),
          ],
          rowBuilder: (data, index) =>
              _rowBuilder(context, data.parkOrders.nodes[index]),
        );
      },
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Fragment$parkingOrderListItem node,
  ) {
    return DataRow(
      onSelectChanged: (_) {
        showDialog(
          context: context,
          useSafeArea: false,
          builder: (context) =>
              ParkSpotDetailOrderDetailDialog(orderId: node.id),
        );
      },
      cells: [
        DataCell(
          Text(
            "#${node.id}",
            style: context.textTheme.labelMedium?.variant(context),
          ),
        ),
        DataCell(node.carOwner?.tableView(context) ?? const SizedBox.shrink()),
        DataCell(Text(node.createdAt.formatDateTime)),
        DataCell(node.price.toCurrency(context, node.currency)),
        DataCell(
          node.paymentMode.tableViewPaymentMethod(
            context,
            node.savedPaymentMethod,
            node.paymentGateway,
          ),
        ),
        DataCell(node.status.toChip(context)),
      ],
    );
  }

  AppSortDropdown<Input$ParkOrderSort> _buildSortOptions(
    BuildContext context,
    ParkSpotDetailOrdersState state,
  ) {
    return AppSortDropdown(
      selectedValues: state.sorting,
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
          field: Enum$ParkOrderSortFields.price,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ParkOrderSort(
          field: Enum$ParkOrderSortFields.price,
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
        Input$ParkOrderSort(
          field: Enum$ParkOrderSortFields.paymentMode,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ParkOrderSort(
          field: Enum$ParkOrderSortFields.paymentMode,
          direction: Enum$SortDirection.DESC,
        ),
      ],
      labelGetter: (sort) =>
          sort.field.tableViewSortLabel(context, sort.direction),
    );
  }

  AppFilterDropdown<Enum$ParkOrderStatus> _buildStatusFilter(
    BuildContext context,
    ParkSpotDetailOrdersState state,
  ) {
    return AppFilterDropdown<Enum$ParkOrderStatus>(
      onChanged: context.read<ParkSpotDetailOrdersBloc>().onStatusFilterChanged,
      selectedValues: state.statusFilter,
      title: context.tr.status,
      items: Enum$ParkOrderStatus.values.toFilterItems(context),
    );
  }
}
