import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/parking_transaction_sort_fields.dart';
import 'package:admin_frontend/core/enums/transaction_status.dart';
import 'package:admin_frontend/core/enums/transaction_type.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/features/parking_insert_transaction/presentation/screens/parking_insert_transaction_dialog.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_transaction.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_transaction.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/parking/parking_accounting/parking_accounting_detail/presentation/blocs/parking_accounting_detail.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ParkingAccountingDetailTransactionsTable extends StatelessWidget {
  const ParkingAccountingDetailTransactionsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ParkingAccountingDetailBloc>();
    return BlocBuilder<
      ParkingAccountingDetailBloc,
      ParkingAccountingDetailState
    >(
      builder: (context, state) {
        return AppDataTable(
          columns: [
            DataColumn2(
              label: Text(context.tr.dateAndTime),
              size: ColumnSize.S,
            ),
            DataColumn(label: Text(context.tr.transactionType)),
            DataColumn(label: Text(context.tr.paymentMethod)),
            DataColumn2(label: Text(context.tr.amount), size: ColumnSize.S),
            DataColumn2(label: Text(context.tr.status), size: ColumnSize.S),
            DataColumn(label: Text(context.tr.referenceNumber)),
          ],
          actions: [
            AppOutlinedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  useSafeArea: false,
                  builder: (context) => ParkingInsertTransactionDialog(
                    parkingId: state.parkingId!,
                  ),
                );
              },
              text: context.tr.insert,
              prefixIcon: BetterIcons.addCircleOutline,
            ),
          ],
          sortOptions: _buildSortOptions(context),
          filterOptions: [
            _buildActionFilter(context, state),
            _buildStatusFilter(context, state),
          ],
          getRowCount: (data) => data.parkingTransactions.nodes.length,
          rowBuilder: (data, index) =>
              _rowBuilder(context, data.parkingTransactions.nodes[index]),
          getPageInfo: (data) => data.parkingTransactions.pageInfo,
          data: state.transactionListState,
          onPageChanged: bloc.onPageChanged,
          paging: state.transactionsPaging,
        );
      },
    );
  }

  AppSortDropdown<Input$ParkingTransactionSort> _buildSortOptions(
    BuildContext context,
  ) {
    return AppSortDropdown(
      items: [
        Input$ParkingTransactionSort(
          field: Enum$ParkingTransactionSortFields.id,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ParkingTransactionSort(
          field: Enum$ParkingTransactionSortFields.id,
          direction: Enum$SortDirection.DESC,
        ),
        Input$ParkingTransactionSort(
          field: Enum$ParkingTransactionSortFields.amount,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ParkingTransactionSort(
          field: Enum$ParkingTransactionSortFields.amount,
          direction: Enum$SortDirection.DESC,
        ),
        Input$ParkingTransactionSort(
          field: Enum$ParkingTransactionSortFields.status,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ParkingTransactionSort(
          field: Enum$ParkingTransactionSortFields.status,
          direction: Enum$SortDirection.DESC,
        ),
      ],
      labelGetter: (sort) =>
          sort.field.tableViewSortLabel(context, sort.direction),
    );
  }

  DataRow _rowBuilder(BuildContext context, Fragment$parkingTransaction node) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            node.createdAt.formatDateTime,
            style: context.textTheme.labelMedium,
          ),
        ),
        DataCell(node.tableViewType(context)),
        DataCell(node.tableViewPaymentMethod(context)),
        DataCell(node.amountView(context)),
        DataCell(node.status.chip(context)),
        DataCell(
          Text(
            node.documentNumber ?? "-",
            style: context.textTheme.labelMedium,
          ),
        ),
      ],
    );
  }

  AppFilterDropdown<Enum$TransactionStatus> _buildStatusFilter(
    BuildContext context,
    ParkingAccountingDetailState state,
  ) {
    return AppFilterDropdown<Enum$TransactionStatus>(
      onChanged: (selectedItems) => context
          .read<ParkingAccountingDetailBloc>()
          .onTransactionStatusFilterChanged(selectedItems),
      selectedValues: state.transactionStatusFilter,
      title: context.tr.status,
      items: [
        FilterItem(label: context.tr.done, value: Enum$TransactionStatus.Done),
        FilterItem(
          label: context.tr.processing,
          value: Enum$TransactionStatus.Processing,
        ),
      ],
    );
  }

  AppFilterDropdown<Enum$TransactionType> _buildActionFilter(
    BuildContext context,
    ParkingAccountingDetailState state,
  ) {
    return AppFilterDropdown<Enum$TransactionType>(
      onChanged: (selectedItems) => context
          .read<ParkingAccountingDetailBloc>()
          .onTransactionTypeFilterChanged(selectedItems),
      selectedValues: state.transactionTypeFilter,
      title: context.tr.transactionType,
      items: Enum$TransactionType.values.toFilterItems(context),
    );
  }
}
