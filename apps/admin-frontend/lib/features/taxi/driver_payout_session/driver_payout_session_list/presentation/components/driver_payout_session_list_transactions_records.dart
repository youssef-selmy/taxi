import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/molecules/table_cells/transaction_amount_cell.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/driver_transaction_sort_fields.dart';
import 'package:admin_frontend/core/enums/transaction_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver.graphql.extensions.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_list/data/graphql/driver_payout_session_list.graphql.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_list/presentation/blocs/driver_payout_session_list.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DriverPayoutSessionListTransactionsRecords extends StatelessWidget {
  const DriverPayoutSessionListTransactionsRecords({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DriverPayoutSessionListBloc>();
    return BlocBuilder<
      DriverPayoutSessionListBloc,
      DriverPayoutSessionListState
    >(
      builder: (context, state) {
        return AppDataTable(
          title: context.tr.financialRecords,
          filterOptions: [
            AppFilterDropdown<Enum$TransactionStatus>(
              title: context.tr.status,
              items: Enum$TransactionStatus.values.filterItems(context),
              onChanged: bloc.onStatusFilterChanged,
            ),
          ],
          columns: [
            DataColumn(label: Text(context.tr.type)),
            DataColumn(label: Text(context.tr.dateAndTime)),
            DataColumn(label: Text(context.tr.amount)),
            DataColumn(label: Text(context.tr.status)),
            DataColumn(label: Text(context.tr.referenceNumber)),
          ],
          sortOptions: _tableSortOptions(context),
          getRowCount: (data) => data.payoutTransactions.nodes.length,
          rowBuilder: (data, index) =>
              _rowBuilder(context, data.payoutTransactions.nodes[index]),
          getPageInfo: (data) => data.payoutTransactions.pageInfo,
          data: state.payoutTransactionsState,
          paging: state.transactionsPaging,
          onPageChanged: bloc.onTransactionsPageChanged,
        );
      },
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Query$driversPayoutTransactions$payoutTransactions$nodes node,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              AppAvatar(imageUrl: node.driver?.media?.address),
              const SizedBox(width: 8),
              Text(
                node.driver?.fullName ?? "-",
                style: context.textTheme.labelMedium,
              ),
            ],
          ),
        ),
        DataCell(Text(node.createdAt.formatDateTime)),
        DataCell(
          AppTransactionAmountCell(
            amount: node.amount,
            currency: node.currency,
          ),
        ),
        DataCell(node.status.chip(context)),
        DataCell(
          Text(
            node.refrenceNumber ?? "-",
            style: context.textTheme.labelMedium,
          ),
        ),
      ],
    );
  }

  AppSortDropdown<Input$DriverTransactionSort> _tableSortOptions(
    BuildContext context,
  ) {
    final bloc = context.read<DriverPayoutSessionListBloc>();
    return AppSortDropdown(
      onChanged: bloc.transactionSortChanged,
      items: [
        Input$DriverTransactionSort(
          field: Enum$DriverTransactionSortFields.action,
          direction: Enum$SortDirection.ASC,
        ),
        Input$DriverTransactionSort(
          field: Enum$DriverTransactionSortFields.action,
          direction: Enum$SortDirection.DESC,
        ),
        Input$DriverTransactionSort(
          field: Enum$DriverTransactionSortFields.createdAt,
          direction: Enum$SortDirection.ASC,
        ),
        Input$DriverTransactionSort(
          field: Enum$DriverTransactionSortFields.createdAt,
          direction: Enum$SortDirection.DESC,
        ),
        Input$DriverTransactionSort(
          field: Enum$DriverTransactionSortFields.status,
          direction: Enum$SortDirection.ASC,
        ),
        Input$DriverTransactionSort(
          field: Enum$DriverTransactionSortFields.status,
          direction: Enum$SortDirection.DESC,
        ),
        Input$DriverTransactionSort(
          field: Enum$DriverTransactionSortFields.amount,
          direction: Enum$SortDirection.ASC,
        ),
        Input$DriverTransactionSort(
          field: Enum$DriverTransactionSortFields.amount,
          direction: Enum$SortDirection.DESC,
        ),
      ],
      labelGetter: (item) =>
          item.field.tableViewSortLabel(context, item.direction),
    );
  }
}
