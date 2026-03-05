import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/sort_direction.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_list/data/graphql/shop_accounting_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_accounting/shop_accounting_list/presentation/blocs/shop_accounting_list.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ShopAccountingListWalletsTable extends StatelessWidget {
  const ShopAccountingListWalletsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShopAccountingListBloc>();
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previousState, currentState) =>
          previousState.supportedCurrencies !=
          previousState.supportedCurrencies,
      builder: (context, stateAuth) {
        return BlocBuilder<ShopAccountingListBloc, ShopAccountingListState>(
          builder: (context, state) {
            return AppDataTable(
              minWidth: 500,
              columns: [
                DataColumn2(label: Text(context.tr.id), fixedWidth: 70),
                DataColumn(label: Text(context.tr.shop)),
                DataColumn(label: Text(context.tr.walletBalance)),
              ],
              filterOptions: [
                AppFilterDropdown<String>(
                  title: context.tr.currency,
                  selectedValues: state.selectedCurrency == null
                      ? null
                      : [state.selectedCurrency!],
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
                  Input$ShopWalletSort(
                    field: Enum$ShopWalletSortFields.balance,
                    direction: Enum$SortDirection.ASC,
                  ),
                  Input$ShopWalletSort(
                    field: Enum$ShopWalletSortFields.balance,
                    direction: Enum$SortDirection.DESC,
                  ),
                ],
                labelGetter: (sort) {
                  switch (sort.field) {
                    case Enum$ShopWalletSortFields.balance:
                      return "${context.tr.walletBalance} (${sort.direction.titleAmount(context)})";
                    default:
                      return "";
                  }
                },
              ),
              getRowCount: (data) => data.shopWallets.nodes.length,
              rowBuilder: (data, index) => _rowBuilder(
                context,
                data.shopWallets.nodes[index],
                state.selectedCurrency ?? Env.defaultCurrency,
              ),
              getPageInfo: (data) => data.shopWallets.pageInfo,
              data: state.walletListState,
              onPageChanged: bloc.onWalletPageChanged,
              paging: state.walletPaging,
            );
          },
        );
      },
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Query$shopWallets$shopWallets$nodes data,
    String currency,
  ) {
    return DataRow(
      onSelectChanged: (value) {
        context.router.push(ShopAccountingDetailRoute(shopId: data.shop.id));
      },
      cells: [
        DataCell(
          Text(
            "#${data.shop.id}",
            style: context.textTheme.labelMedium?.variant(context),
          ),
        ),
        DataCell(
          Row(
            children: [
              AppAvatar(
                imageUrl: data.shop.image?.address,
                size: AvatarSize.size40px,
              ),
              const SizedBox(width: 8),
              Text(data.shop.name, style: context.textTheme.labelMedium),
            ],
          ),
        ),
        DataCell(data.balance.toCurrency(context, currency)),
      ],
    );
  }
}
