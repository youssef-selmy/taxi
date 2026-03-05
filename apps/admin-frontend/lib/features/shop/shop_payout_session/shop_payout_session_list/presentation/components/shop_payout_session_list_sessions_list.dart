import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/payout_session_status.dart';
import 'package:admin_frontend/core/enums/shop_payout_session_status_sort_fields.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/payout_method.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_payout.fragment.graphql.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/shop/shop_payout_session/shop_payout_session_list/presentation/blocs/shop_payout_session_list.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ShopPayoutSessionListSessionsList extends StatelessWidget {
  const ShopPayoutSessionListSessionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShopPayoutSessionListBloc>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child:
            BlocBuilder<ShopPayoutSessionListBloc, ShopPayoutSessionListState>(
              builder: (context, state) {
                return AppDataTable(
                  useSafeArea: false,
                  title: context.tr.payoutSessions,
                  isHeaderTransparent: true,
                  sortOptions: _tableSortOptions(context, state),
                  filterOptions: [_tableStatusFilter(context, state)],
                  columns: [DataColumn(label: Text(context.tr.list))],
                  getRowCount: (data) => data.shopPayoutSessions.nodes.length,
                  rowBuilder: (data, index) => _rowBuilder(
                    context,
                    data.shopPayoutSessions.nodes[index],
                  ),
                  getPageInfo: (data) => data.shopPayoutSessions.pageInfo,
                  data: state.payoutSessionsState,
                  paging: state.sessionsPaging,
                  onPageChanged: bloc.onSessionsPageChanged,
                );
              },
            ),
      ),
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Fragment$shopPayoutSessionListItem node,
  ) {
    return DataRow(
      onSelectChanged: (value) {
        context.router.push(
          ShopPayoutSessionDetailRoute(payoutSessionId: node.id),
        );
      },
      cells: [
        DataCell(
          Row(
            children: [
              node.shopTransactions.nodes
                  .map((transaction) => transaction.shop.image)
                  .nonNulls
                  .toList()
                  .avatarsView(
                    context: context,
                    totalCount: node.shopTransactions.totalCount,
                    size: AvatarGroupSize.medium,
                  ),
              const SizedBox(width: 16),
              Text(
                "${context.tr.session} #${node.id}",
                style: context.textTheme.labelMedium,
              ),
              const SizedBox(width: 12),
              node.status.toChip(context),
              const Spacer(flex: 3),
              Text(
                "${context.tr.total}: ",
                style: context.textTheme.labelMedium?.variant(context),
              ),
              node.totalAmount.toCurrency(context, node.currency),
              const Spacer(),
              ...node.payoutMethods.map(
                (payoutMethod) => payoutMethod.tableView(context),
              ),
              const SizedBox(width: 16),
              Text(
                node.createdAt.formatDateTime,
                style: context.textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  AppSortDropdown<Input$ShopPayoutSessionSort> _tableSortOptions(
    BuildContext context,
    ShopPayoutSessionListState state,
  ) {
    final bloc = context.read<ShopPayoutSessionListBloc>();
    return AppSortDropdown(
      onChanged: (p0) => bloc.onSessionsSortChanged,
      items: [
        Input$ShopPayoutSessionSort(
          field: Enum$ShopPayoutSessionSortFields.totalAmount,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ShopPayoutSessionSort(
          field: Enum$ShopPayoutSessionSortFields.totalAmount,
          direction: Enum$SortDirection.DESC,
        ),
        Input$ShopPayoutSessionSort(
          field: Enum$ShopPayoutSessionSortFields.status,
          direction: Enum$SortDirection.ASC,
        ),
        Input$ShopPayoutSessionSort(
          field: Enum$ShopPayoutSessionSortFields.status,
          direction: Enum$SortDirection.DESC,
        ),
      ],
      selectedValues: state.payoutSessionSort,
      labelGetter: (object) =>
          object.field.tableViewSortLabel(context, object.direction),
    );
  }

  AppFilterDropdown<Enum$PayoutSessionStatus> _tableStatusFilter(
    BuildContext context,
    ShopPayoutSessionListState state,
  ) {
    final bloc = context.read<ShopPayoutSessionListBloc>();
    return AppFilterDropdown<Enum$PayoutSessionStatus>(
      selectedValues: state.payoutSessionStatusFilter,
      title: context.tr.status,
      items: Enum$PayoutSessionStatus.values.toFilterItems(context),
      onChanged: bloc.onSessionStatusFilterChanged,
    );
  }
}
