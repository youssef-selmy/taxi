import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/molecules/table_cells/transaction_amount_cell.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/wallet_balance/wallet_balance.dart';
import 'package:admin_frontend/core/enums/fleet_transaction_sort_field.dart';
import 'package:admin_frontend/core/enums/transaction_action.dart';
import 'package:admin_frontend/core/enums/transaction_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/blocs/financial_records.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FinancialInformations extends StatelessWidget {
  const FinancialInformations({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FleetFinancialRecordsBloc>();
    return BlocConsumer<FleetFinancialRecordsBloc, FinancialRecordsState>(
      listenWhen: (previous, current) =>
          previous.exportState != current.exportState,
      listener: (context, state) {
        switch (state.exportState) {
          case ApiResponseLoaded(:final data):
            context.showSuccess(context.tr.successExportMessage);
            launchUrlString(data);
            break;

          case ApiResponseError():
            context.showFailure(state.exportState);
            break;

          default:
            break;
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              WalletBalanceCard(items: state.fleetWallet),
              //table
              const SizedBox(height: 31),
              Row(
                children: [
                  Text(
                    context.tr.transactionsRecords,
                    style: context.textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  AppFilledButton(
                    prefixIcon: BetterIcons.share08Outline,
                    text: context.tr.export,
                    onPressed: () {
                      bloc.onExport(Enum$ExportFormat.CSV);
                    },
                  ),
                  const SizedBox(width: 8),
                  AppOutlinedButton(
                    text: context.tr.print,
                    onPressed: () {
                      bloc.onExport(Enum$ExportFormat.PDF);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 420,
                child: AppDataTable(
                  columns: [
                    DataColumn(label: Text(context.tr.dateAndTime)),
                    DataColumn2(
                      label: Text(context.tr.transactionType),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Text(context.tr.amount),
                      size: ColumnSize.S,
                    ),
                    DataColumn(label: Text(context.tr.status)),
                    DataColumn(label: Text(context.tr.referenceNumber)),
                  ],
                  sortOptions: AppSortDropdown(
                    selectedValues: state.sortFields,
                    onChanged: (value) {
                      bloc.onSortingChanged(value);
                    },
                    items: [
                      Input$FleetTransactionSort(
                        field: Enum$FleetTransactionSortFields.id,
                        direction: Enum$SortDirection.ASC,
                      ),
                      Input$FleetTransactionSort(
                        field: Enum$FleetTransactionSortFields.id,
                        direction: Enum$SortDirection.DESC,
                      ),
                      Input$FleetTransactionSort(
                        field: Enum$FleetTransactionSortFields.status,
                        direction: Enum$SortDirection.ASC,
                      ),
                      Input$FleetTransactionSort(
                        field: Enum$FleetTransactionSortFields.status,
                        direction: Enum$SortDirection.DESC,
                      ),
                    ],
                    labelGetter: (item) =>
                        item.field.tableViewSortLabel(context, item.direction),
                  ),
                  filterOptions: [
                    AppFilterDropdown<Enum$TransactionAction>(
                      title: context.tr.transactionType,
                      selectedValues: state.transactionFilter,
                      onChanged: bloc.onTransactionFilterChanged,
                      items: Enum$TransactionAction.values
                          .where((e) => e != Enum$TransactionAction.$unknown)
                          .map(
                            (status) => FilterItem(
                              label: status.name(context),
                              value: status,
                            ),
                          )
                          .toList(),
                    ),
                    AppFilterDropdown<Enum$TransactionStatus>(
                      title: context.tr.status,
                      selectedValues: state.statusFilter,
                      onChanged: bloc.onStatusFilterChanged,
                      items: Enum$TransactionStatus.values
                          .where((e) => e != Enum$TransactionStatus.$unknown)
                          .map(
                            (status) =>
                                FilterItem(label: status.name, value: status),
                          )
                          .toList(),
                    ),
                  ],
                  getRowCount: (data) => data.fleetTransactions.nodes.length,
                  rowBuilder: (Query$fleetTransactions data, int index) =>
                      rowBuilder(context, data, index),
                  getPageInfo: (data) => data.fleetTransactions.pageInfo,
                  data: state.fleetTransaction,
                  paging: state.paging,
                  onPageChanged: context
                      .read<FleetFinancialRecordsBloc>()
                      .onPageChanged,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  DataRow rowBuilder(
    BuildContext context,
    Query$fleetTransactions data,
    int index,
  ) {
    final fleetTransactions = data.fleetTransactions.nodes[index];
    return DataRow(
      onSelectChanged: (value) {},
      cells: [
        DataCell(Text(fleetTransactions.transactionTimestamp.formatDateTime)),
        DataCell(
          Row(
            children: [
              fleetTransactions.action.icon(context),
              const SizedBox(width: 4),
              Text(fleetTransactions.action.name(context)),
            ],
          ),
        ),
        DataCell(
          AppTransactionAmountCell(
            amount: fleetTransactions.amount,
            currency: fleetTransactions.currency,
          ),
        ),
        DataCell(fleetTransactions.status.chip(context)),
        DataCell(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              fleetTransactions.refrenceNumber ?? '',
              style: context.textTheme.labelMedium,
            ),
          ),
        ),
      ],
    );
  }
}
