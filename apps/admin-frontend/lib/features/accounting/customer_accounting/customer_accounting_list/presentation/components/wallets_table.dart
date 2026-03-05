import 'package:admin_frontend/config/env.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_list/data/graphql/customer_accounting_list.graphql.dart';
import 'package:admin_frontend/features/accounting/customer_accounting/customer_accounting_list/presentation/blocs/customer_accounting_list.bloc.dart';
import 'package:admin_frontend/schema.graphql.dart';

class CustomerAccountingListWalletsTable extends StatelessWidget {
  const CustomerAccountingListWalletsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CustomerAccountingListBloc>();
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previousState, currentState) =>
          previousState.supportedCurrencies !=
          previousState.supportedCurrencies,
      builder: (context, stateAuth) {
        return BlocBuilder<
          CustomerAccountingListBloc,
          CustomerAccountingListState
        >(
          builder: (context, state) {
            return AppDataTable(
              columns: [
                DataColumn2(label: Text(context.tr.id), fixedWidth: 60),
                DataColumn(label: Text(context.tr.customer)),
                DataColumn(label: Text(context.tr.walletBalance)),
              ],
              filterOptions: [
                AppFilterDropdown<String>(
                  title: context.tr.currency,
                  selectedValues: [
                    state.selectedCurrency ?? Env.defaultCurrency,
                  ],
                  onChanged: bloc.changeCurrency,
                  items: stateAuth.supportedCurrencies
                      .map(
                        (currency) =>
                            FilterItem(value: currency, label: currency),
                      )
                      .toList(),
                ),
              ],
              sortOptions: AppSortDropdown(
                onChanged: bloc.changeWalletSortings,
                items: [
                  Input$RiderWalletSort(
                    field: Enum$RiderWalletSortFields.balance,
                    direction: Enum$SortDirection.ASC,
                  ),
                  Input$RiderWalletSort(
                    field: Enum$RiderWalletSortFields.balance,
                    direction: Enum$SortDirection.DESC,
                  ),
                ],
                labelGetter: (sort) {
                  switch (sort.field) {
                    case Enum$RiderWalletSortFields.balance:
                      return "${context.tr.walletBalance} (${sort.direction.titleAmount(context)})";
                    default:
                      return "";
                  }
                },
              ),
              getRowCount: (data) => data.riderWallets.nodes.length,
              rowBuilder: (data, index) => _rowBuilder(
                context,
                data.riderWallets.nodes[index],
                state.selectedCurrency ?? Env.defaultCurrency,
              ),
              getPageInfo: (data) => data.riderWallets.pageInfo,
              data: state.walletListState,
              onPageChanged: bloc.onPageChanged,
              paging: state.walletPaging,
            );
          },
        );
      },
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Query$customerWallets$riderWallets$nodes data,
    String currency,
  ) {
    return DataRow(
      onSelectChanged: data.rider == null
          ? null
          : (value) {
              context.router.push(
                CustomerAccountingDetailRoute(customerId: data.rider!.id),
              );
            },
      cells: [
        DataCell(
          Text(
            "#${data.rider?.id ?? "-"}",
            style: context.textTheme.labelMedium?.variant(context),
          ),
        ),
        DataCell(
          data.rider == null
              ? Text(context.tr.unknown)
              : Row(
                  children: [
                    data.rider!.media.widget(width: 40, height: 40),
                    const SizedBox(width: 8),
                    Text(
                      data.rider!.fullName,
                      style: context.textTheme.labelMedium,
                    ),
                  ],
                ),
        ),
        DataCell(data.balance.toCurrency(context, currency)),
      ],
    );
  }
}
