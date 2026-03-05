import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/wallet_balance/wallet_balance.dart';
import 'package:admin_frontend/core/enums/customer_transaction_sort_fields.dart';
import 'package:admin_frontend/core/enums/transaction_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/features/customer_insert_transaction/presentation/screens/customer_insert_transaction_dialog.dart';
import 'package:admin_frontend/core/graphql/fragments/customer_transaction.graphql.extensions.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/blocs/credit_records.cubit.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/blocs/customer_details.cubit.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/screens/dialogs/transaction_details.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CustomerDetailsCreditRecords extends StatelessWidget {
  final String customerId;

  const CustomerDetailsCreditRecords({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CreditRecordsBloc()..onStarted(customerId: customerId),
      child: BlocConsumer<CreditRecordsBloc, CreditRecordsState>(
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<CreditRecordsBloc, CreditRecordsState>(
                  builder: (context, state) {
                    return WalletBalanceCard(items: state.walletState);
                  },
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.tr.creditRecords,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                    AppFilledButton(
                      text: context.tr.export,
                      onPressed: () {
                        context.read<CreditRecordsBloc>().export(
                          Enum$ExportFormat.CSV,
                        );
                      },
                      prefixIcon: BetterIcons.share08Outline,
                    ),
                    const SizedBox(width: 8),
                    AppOutlinedButton(
                      onPressed: () {
                        context.read<CreditRecordsBloc>().export(
                          Enum$ExportFormat.PDF,
                        );
                      },
                      text: context.tr.print,
                      color: SemanticColor.neutral,
                    ),
                    const SizedBox(width: 8),
                    AppOutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          useSafeArea: false,
                          builder: (context) => CustomerInsertTransactionDialog(
                            customerId: customerId,
                          ),
                        );
                      },
                      text: context.tr.insert,
                      prefixIcon: BetterIcons.addCircleOutline,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 600,
                  child: BlocBuilder<CreditRecordsBloc, CreditRecordsState>(
                    builder: (context, state) {
                      return AppDataTable(
                        sortOptions: _buildSortOptions(context, state),
                        filterOptions: [
                          _buildStatusFilter(context, state),
                          _buildActionFilter(context, state),
                        ],
                        minWidth: 1200,
                        columns: [
                          DataColumn2(
                            label: Text(context.tr.dateAndTime),
                            size: ColumnSize.S,
                          ),
                          DataColumn(label: Text(context.tr.transactionType)),
                          DataColumn(label: Text(context.tr.paymentMethod)),
                          DataColumn2(
                            label: Text(context.tr.amount),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Text(context.tr.status),
                            size: ColumnSize.S,
                          ),
                          DataColumn(label: Text(context.tr.referenceNumber)),
                        ],
                        getRowCount: (data) =>
                            data.riderTransactions.nodes.length,
                        rowBuilder: (data, index) {
                          final transaction =
                              data.riderTransactions.nodes[index];
                          return DataRow(
                            onSelectChanged: (value) {
                              final customer = context
                                  .read<CustomerDetailsBloc>()
                                  .state
                                  .customerDetailsState
                                  .data!;
                              showDialog(
                                context: context,
                                builder: (context) => TransactionDetailsDialog(
                                  customer: customer,
                                  transaction: transaction,
                                ),
                              );
                            },
                            cells: [
                              DataCell(
                                Text(transaction.createdAt.formatDateTime),
                              ),
                              DataCell(transaction.tableViewType(context)),
                              DataCell(
                                transaction.tableViewPaymentMethod(context),
                              ),
                              DataCell(transaction.amountView(context)),
                              DataCell(transaction.status.chip(context)),
                              DataCell(Text(transaction.refrenceNumber ?? "")),
                            ],
                          );
                        },
                        getPageInfo: (data) => data.riderTransactions.pageInfo,
                        data: state.creditRecordsState,
                        paging: state.paging,
                        onPageChanged: context
                            .read<CreditRecordsBloc>()
                            .onPageChanged,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  AppFilterDropdown<Enum$TransactionStatus> _buildStatusFilter(
    BuildContext context,
    CreditRecordsState state,
  ) {
    return AppFilterDropdown<Enum$TransactionStatus>(
      onChanged: (selectedItems) => context
          .read<CreditRecordsBloc>()
          .onTransactionStatusFilterChanged(selectedItems),
      selectedValues: state.transactionStatusFilters,
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
    CreditRecordsState state,
  ) {
    return AppFilterDropdown<Enum$TransactionAction>(
      onChanged: (selectedItems) => context
          .read<CreditRecordsBloc>()
          .onTransactionActionFilterChanged(selectedItems),
      selectedValues: state.transactionActionFilters,
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

  AppSortDropdown<Input$RiderTransactionSort> _buildSortOptions(
    BuildContext context,
    CreditRecordsState state,
  ) {
    return AppSortDropdown<Input$RiderTransactionSort>(
      overlayWidth: 230,
      labelGetter: (p0) => p0.field.tableViewSortLabel(context, p0.direction),
      onChanged: (selectedItems) => context
          .read<CreditRecordsBloc>()
          .onTransactionSortChanged(selectedItems),
      selectedValues: state.transactionSorts,
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
    );
  }
}
