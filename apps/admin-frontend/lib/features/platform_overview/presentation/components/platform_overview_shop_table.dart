import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/shop_order_sort_fields.dart';
import 'package:admin_frontend/core/enums/shop_order_status.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/platform_overview/data/graphql/platform_overview.graphql.dart';
import 'package:admin_frontend/features/platform_overview/presentation/blocs/platform_overview.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlatformOverviewShopTable extends StatelessWidget {
  const PlatformOverviewShopTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlatformOverviewCubit, PlatformOverviewState>(
      builder: (context, state) {
        return AppDataTable(
          searchBarOptions: TableSearchBarOptions(enabled: false),
          columns: [
            DataColumn2(label: Text(context.tr.id), fixedWidth: 70),
            DataColumn2(label: Text(context.tr.rider), size: ColumnSize.L),
            DataColumn2(label: Text(context.tr.status), size: ColumnSize.L),
            DataColumn(label: Text(context.tr.dateAndTime)),
            DataColumn(label: Text(context.tr.assignToSelectedDriver)),
          ],
          sortOptions: AppSortDropdown<Input$ShopOrderSort>(
            selectedValues: state.shopSortFields,
            onChanged: (value) {
              context.read<PlatformOverviewCubit>().onShopSortingChanged(value);
            },
            items: [
              Input$ShopOrderSort(
                field: Enum$ShopOrderSortFields.id,
                direction: Enum$SortDirection.ASC,
              ),
              Input$ShopOrderSort(
                field: Enum$ShopOrderSortFields.id,
                direction: Enum$SortDirection.DESC,
              ),
              Input$ShopOrderSort(
                field: Enum$ShopOrderSortFields.status,
                direction: Enum$SortDirection.ASC,
              ),
              Input$ShopOrderSort(
                field: Enum$ShopOrderSortFields.status,
                direction: Enum$SortDirection.DESC,
              ),
            ],
            labelGetter: (item) =>
                item.field.tableViewSortLabel(context, item.direction),
          ),
          getRowCount: (data) => data.shopOrders.nodes.length,
          rowBuilder: (data, int index) => rowBuilder(context, data, index),
          getPageInfo: (data) => data.shopOrders.pageInfo,
          data: state.shopOrders,
          paging: state.shopOrdersPaging,
          onPageChanged: context
              .read<PlatformOverviewCubit>()
              .onShopOrdersPageChanged,
        );
      },
    );
  }
}

DataRow rowBuilder(BuildContext context, Query$shopOrders data, int index) {
  final shopOrder = data.shopOrders.nodes[index];
  return DataRow(
    onSelectChanged: (value) {
      locator<AuthBloc>().add(AuthEvent.changeAppType(Enum$AppType.Shop));
      context.router.navigate(
        ShopShellRoute(
          children: [
            ShopOrderShellRoute(
              children: [ShopOrderDetailRoute(shopOrderId: shopOrder.id)],
            ),
          ],
        ),
      );
    },
    cells: [
      DataCell(
        Text(
          '#${shopOrder.id}',
          style: context.textTheme.labelMedium?.variant(context),
        ),
      ),
      DataCell(shopOrder.customer.tableView(context)),
      DataCell(shopOrder.status.chip(context)),
      DataCell(
        Text(
          shopOrder.createdAt.formatDateTime,
          style: context.textTheme.labelMedium,
        ),
      ),
      DataCell(shopOrder.customer.tableView(context)),
    ],
  );
}
