import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/customer_transaction_sort_fields.dart';
import 'package:admin_frontend/core/enums/transaction_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/features/customer_insert_transaction/presentation/screens/customer_insert_transaction_dialog.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.extensions.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_detail/presentation/blocs/customer_accounting_detail.bloc.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class CustomerAccountingDetailTransactionsTable extends StatelessWidget {
  const CustomerAccountingDetailTransactionsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CustomerAccountingDetailBloc>();
    return BlocBuilder<
      CustomerAccountingDetailBloc,
      CustomerAccountingDetailState
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
                  builder: (context) => CustomerInsertTransactionDialog(
                    customerId: state.customerId!,
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
          getRowCount: (data) => data.riderTransactions.nodes.length,
          rowBuilder: (data, index) =>
              _rowBuilder(context, data.riderTransactions.nodes[index]),
          getPageInfo: (data) => data.riderTransactions.pageInfo,
          data: state.transactionListState,
          onPageChanged: bloc.onTransactionsPageChanged,
          paging: state.transactionsPaging,
        );
      },
    );
  }

  AppSortDropdown<Input$RiderTransactionSort> _buildSortOptions(
    BuildContext context,
  ) {
    return AppSortDropdown(
      items: [
        Input$RiderTransactionSort(
          field: Enum$RiderTransactionSortFields.action,
          direction: Enum$SortDirection.ASC,
        ),
        Input$RiderTransactionSort(
          field: Enum$RiderTransactionSortFields.action,
          direction: Enum$SortDirection.DESC,
        ),
        Input$RiderTransactionSort(
          field: Enum$RiderTransactionSortFields.createdAt,
          direction: Enum$SortDirection.ASC,
        ),
        Input$RiderTransactionSort(
          field: Enum$RiderTransactionSortFields.createdAt,
          direction: Enum$SortDirection.DESC,
        ),
        Input$RiderTransactionSort(
          field: Enum$RiderTransactionSortFields.amount,
          direction: Enum$SortDirection.ASC,
        ),
        Input$RiderTransactionSort(
          field: Enum$RiderTransactionSortFields.amount,
          direction: Enum$SortDirection.DESC,
        ),
        Input$RiderTransactionSort(
          field: Enum$RiderTransactionSortFields.status,
          direction: Enum$SortDirection.ASC,
        ),
        Input$RiderTransactionSort(
          field: Enum$RiderTransactionSortFields.status,
          direction: Enum$SortDirection.DESC,
        ),
      ],
      labelGetter: (sort) =>
          sort.field.tableViewSortLabel(context, sort.direction),
    );
  }

  DataRow _rowBuilder(BuildContext context, Fragment$customerTransaction node) {
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
            node.refrenceNumber ?? "-",
            style: context.textTheme.labelMedium,
          ),
        ),
      ],
    );
  }

  AppFilterDropdown<Enum$TransactionStatus> _buildStatusFilter(
    BuildContext context,
    CustomerAccountingDetailState state,
  ) {
    return AppFilterDropdown<Enum$TransactionStatus>(
      onChanged: (selectedItems) => context
          .read<CustomerAccountingDetailBloc>()
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

  AppFilterDropdown<Enum$TransactionAction> _buildActionFilter(
    BuildContext context,
    CustomerAccountingDetailState state,
  ) {
    return AppFilterDropdown<Enum$TransactionAction>(
      onChanged: (selectedItems) => context
          .read<CustomerAccountingDetailBloc>()
          .onTransactionActionFilterChanged(selectedItems),
      selectedValues: state.transactionActionFilter,
      title: context.tr.transactionType,
      items: [
        FilterItem<Enum$TransactionAction>(
          label: context.tr.deposit,
          value: Enum$TransactionAction.Recharge,
        ),
        FilterItem<Enum$TransactionAction>(
          label: context.tr.withdraw,
          value: Enum$TransactionAction.Deduct,
        ),
      ],
    );
  }
}
