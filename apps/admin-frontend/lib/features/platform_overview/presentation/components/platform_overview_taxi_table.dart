import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/taxi_order_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/documents/taxi_orders.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/features/platform_overview/presentation/blocs/platform_overview.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/molecules/table_cells/profile_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlatformOverviewTaxiTable extends StatelessWidget {
  const PlatformOverviewTaxiTable({super.key});

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
          getRowCount: (data) => data.taxiOrders.edges.length,
          rowBuilder: (data, int index) => rowBuilder(context, data, index),
          getPageInfo: (data) => Fragment$OffsetPageInfo(
            hasNextPage: data.taxiOrders.pageInfo.hasNextPage,
            hasPreviousPage: data.taxiOrders.pageInfo.hasPreviousPage,
          ),
          data: state.taxiOrders,
          paging: Input$OffsetPaging(
            limit: state.taxiOrdersPaging?.first,
            offset: state.taxiOrdersPaging?.after,
          ),
          onPageChanged: context
              .read<PlatformOverviewCubit>()
              .onTaxiOrdersPageChanged,
        );
      },
    );
  }
}

DataRow rowBuilder(BuildContext context, Query$taxiOrders data, int index) {
  final order = data.taxiOrders.edges[index];
  return DataRow(
    onSelectChanged: (value) {
      locator<AuthBloc>().add(AuthEvent.changeAppType(Enum$AppType.Taxi));
      context.router.navigate(
        TaxiShellRoute(
          children: [
            TaxiOrderShellRoute(
              children: [TaxiOrderDetailRoute(orderId: order.id)],
            ),
          ],
        ),
      );
    },
    cells: [
      DataCell(
        Text(
          '#${order.id}',
          style: context.textTheme.labelMedium?.variant(context),
        ),
      ),
      DataCell(
        AppProfileCell(
          name: order.rider.fullName ?? "N/A",
          imageUrl: order.rider.imageUrl,
          subtitle: order.rider.mobileNumber.formatPhoneNumber(null),
        ),
      ),
      DataCell(order.status.chip(context)),
      DataCell(
        Text(
          order.createdAt.formatDateTime,
          style: context.textTheme.labelMedium,
        ),
      ),
      DataCell(
        AppProfileCell(
          name: order.driver?.fullName ?? context.tr.searching,
          imageUrl: order.driver?.imageUrl,
          subtitle: order.driver?.mobileNumber.formatPhoneNumber(null),
        ),
      ),
    ],
  );
}
