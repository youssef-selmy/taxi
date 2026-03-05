import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/avatar/avatar_size.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/enums/shop_order_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/shop/shop_overview/presentation/blocs/shop_overview.bloc.dart';
import 'package:better_icons/better_icons.dart';

class ShopOverviewActiveOrders extends StatelessWidget {
  const ShopOverviewActiveOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ShopOverviewBloc>();
    return BlocBuilder<ShopOverviewBloc, ShopOverviewState>(
      builder: (context, state) {
        return Column(
          children: [
            LargeHeader(
              title: context.tr.activeOrders,
              counter: context.isDesktop
                  ? state.activeOrdersState.data?.activeOrders.totalCount ?? 0
                  : null,
              actions: [
                AppOutlinedButton(
                  onPressed: () {
                    context.router.push(ShopDispatcherRoute());
                  },
                  prefixIcon: BetterIcons.rocket01Filled,
                  text: context.tr.dispatchAnOrder,
                ),
                AppOutlinedButton(
                  onPressed: () {
                    context.router.push(ShopOrderListRoute());
                  },
                  color: SemanticColor.neutral,
                  text: context.tr.viewAll,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 365,
              child: AppDataTable(
                useSafeArea: false,
                columns: [
                  DataColumn2(label: Text(context.tr.id), fixedWidth: 70),
                  DataColumn(label: Text(context.tr.customer)),
                  DataColumn(label: Text(context.tr.scheduledFor)),
                  DataColumn2(label: Text(context.tr.status)),
                  DataColumn(label: Text(context.tr.shop)),
                ],
                getRowCount: (data) => data.activeOrders.nodes.length,
                rowBuilder: (data, index) =>
                    _rowBuilder(context, data.activeOrders.nodes[index]),
                getPageInfo: (data) => data.activeOrders.pageInfo,
                data: state.activeOrdersState,
                onPageChanged: bloc.onActiveOrdersPageChanged,
                paging: state.activeOrdersPaging,
              ),
            ),
          ],
        );
      },
    );
  }

  DataRow _rowBuilder(BuildContext context, Fragment$shopOrderListItem node) {
    return DataRow(
      onSelectChanged: (value) {
        context.router.push(ShopOrderDetailRoute(shopOrderId: node.id));
      },
      cells: [
        DataCell(
          Text(
            "#${node.id}",
            style: context.textTheme.labelMedium?.variant(context),
          ),
        ),
        DataCell(node.customer.tableView(context)),
        DataCell(
          Text(
            node.createdAt.formatDateTime,
            style: context.textTheme.labelMedium?.variant(context),
          ),
        ),
        DataCell(node.status.chip(context)),
        DataCell(
          node.carts
              .map((cart) => cart.shop)
              .toList()
              .tableView(context, size: AvatarSize.size32px),
        ),
      ],
    );
  }
}
