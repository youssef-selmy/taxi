import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/molecules/table_cells/transaction_amount_cell.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/provider_transaction_sort_field.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/admin_wallet.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/admin_wallet.graphql.extensions.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/presentation/blocs/admin_accounting_dashboard.bloc.dart';
import 'package:admin_frontend/features/accounting/admin_accounting/admin_accounting_dashboard/presentation/screens/admin_accounting_insert_transaction_dialog.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class AdminAccountingDashboardTransactionList extends StatelessWidget {
  const AdminAccountingDashboardTransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AdminAccountingDashboardBloc>();
    return BlocBuilder<
      AdminAccountingDashboardBloc,
      AdminAccountingDashboardState
    >(
      builder: (context, state) {
        return SizedBox(
          height: 500,
          child: AppDataTable(
            title: context.tr.financialRecords,
            titleSize: TitleSize.small,
            actions: [
              AppFilledButton(
                prefixIcon: BetterIcons.share08Outline,
                text: context.tr.export,
                onPressed: () {
                  bloc.onExport(Enum$ExportFormat.CSV);
                },
              ),
              AppOutlinedButton(
                text: context.tr.print,
                color: SemanticColor.neutral,
                onPressed: () {
                  bloc.onExport(Enum$ExportFormat.PDF);
                },
              ),
              AppOutlinedButton(
                onPressed: () async {
                  final insertTransactionDialogResult = await showDialog(
                    context: context,
                    useSafeArea: false,
                    builder: (context) {
                      return const AdminAccountingInsertTransactionDialog();
                    },
                  );
                  if (insertTransactionDialogResult != null) {
                    // ignore: use_build_context_synchronously
                    context.read<AdminAccountingDashboardBloc>().onStarted();
                  }
                },
                text: context.tr.insert,
                prefixIcon: BetterIcons.addCircleOutline,
              ),
            ],
            filterOptions: [
              AppFilterDropdown(
                title: context.tr.transactionType,
                items: [
                  FilterItem(
                    value: Enum$TransactionAction.Deduct,
                    label: context.tr.debit,
                  ),
                  FilterItem(
                    value: Enum$TransactionAction.Recharge,
                    label: context.tr.credit,
                  ),
                ],
              ),
            ],
            sortOptions: AppSortDropdown<Input$ProviderTransactionSort>(
              items: [
                Input$ProviderTransactionSort(
                  field: Enum$ProviderTransactionSortFields.id,
                  direction: Enum$SortDirection.ASC,
                ),
                Input$ProviderTransactionSort(
                  field: Enum$ProviderTransactionSortFields.id,
                  direction: Enum$SortDirection.DESC,
                ),
                Input$ProviderTransactionSort(
                  field: Enum$ProviderTransactionSortFields.action,
                  direction: Enum$SortDirection.ASC,
                ),
                Input$ProviderTransactionSort(
                  field: Enum$ProviderTransactionSortFields.action,
                  direction: Enum$SortDirection.DESC,
                ),
                Input$ProviderTransactionSort(
                  field: Enum$ProviderTransactionSortFields.deductType,
                  direction: Enum$SortDirection.ASC,
                ),
                Input$ProviderTransactionSort(
                  field: Enum$ProviderTransactionSortFields.deductType,
                  direction: Enum$SortDirection.DESC,
                ),
                Input$ProviderTransactionSort(
                  field: Enum$ProviderTransactionSortFields.rechargeType,
                  direction: Enum$SortDirection.ASC,
                ),
                Input$ProviderTransactionSort(
                  field: Enum$ProviderTransactionSortFields.rechargeType,
                  direction: Enum$SortDirection.DESC,
                ),
                Input$ProviderTransactionSort(
                  field: Enum$ProviderTransactionSortFields.expenseType,
                  direction: Enum$SortDirection.ASC,
                ),
                Input$ProviderTransactionSort(
                  field: Enum$ProviderTransactionSortFields.expenseType,
                  direction: Enum$SortDirection.DESC,
                ),
              ],
              labelGetter: (sort) =>
                  sort.field.tableViewSortLabel(context, sort.direction),
            ),
            columns: [
              DataColumn(label: Text(context.tr.dateAndTime)),
              DataColumn(label: Text(context.tr.transactionType)),
              DataColumn(label: Text(context.tr.amount)),
              DataColumn(label: Text(context.tr.referenceNumber)),
            ],
            getRowCount: (data) => data.adminTransactions.nodes.length,
            rowBuilder: (data, index) =>
                _rowBuilder(context, data.adminTransactions.nodes[index]),
            getPageInfo: (data) => data.adminTransactions.pageInfo,
            data: state.transactionsState,
            onPageChanged: bloc.onPageChanged,
            paging: state.transactionsPaging,
          ),
        );
      },
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Fragment$adminTransactionListItem nod,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(nod.createdAt.formatDateTime)),
        DataCell(nod.tableViewType(context)),
        DataCell(
          AppTransactionAmountCell(amount: nod.amount, currency: nod.currency),
        ),
        DataCell(Text(nod.refrenceNumber ?? "-")),
      ],
    );
  }
}
