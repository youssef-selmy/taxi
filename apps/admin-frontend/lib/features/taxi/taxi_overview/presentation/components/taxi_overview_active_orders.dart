import 'package:admin_frontend/core/graphql/fragments/page_info.extensions.dart';
import 'package:admin_frontend/features/dashboard/presentation/blocs/dashboard.cubit.dart';
import 'package:better_design_system/molecules/table_cells/profile_cell.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/components/headers/large_header.dart';
import 'package:admin_frontend/core/enums/taxi_order_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/presentation/blocs/taxi_overview.bloc.dart';
import 'package:better_icons/better_icons.dart';

class TaxiOverviewActiveOrders extends StatelessWidget {
  const TaxiOverviewActiveOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaxiOverviewBloc>();
    return BlocBuilder<TaxiOverviewBloc, TaxiOverviewState>(
      builder: (context, state) {
        return Column(
          children: [
            LargeHeader(
              title: context.tr.activeOrders,
              counter: context.isDesktop
                  ? state.activeOrdersState.data?.taxiOrders.totalCount ?? 0
                  : null,
              actions: [
                AppOutlinedButton(
                  onPressed: () {
                    context.router.push(DispatcherTaxiRoute());
                  },
                  prefixIcon: BetterIcons.rocket01Filled,
                  text: context.tr.dispatchATrip,
                ),
                AppOutlinedButton(
                  onPressed: () {
                    context.read<DashboardBloc>().goToRoute(
                      TaxiOrderShellRoute(),
                    );
                    context.router.replaceAll([
                      TaxiOrderShellRoute(children: [TaxiOrderListRoute()]),
                    ]);
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
                columns: [
                  DataColumn2(label: Text(context.tr.id), fixedWidth: 70),
                  DataColumn(label: Text(context.tr.customer)),
                  DataColumn2(
                    label: Text(context.tr.scheduledFor),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text(context.tr.status),
                    size: ColumnSize.M,
                  ),
                  DataColumn(label: Text(context.tr.driver)),
                ],
                getRowCount: (data) => data.taxiOrders.edges.length,
                rowBuilder: (data, index) =>
                    _rowBuilder(context, data.taxiOrders.edges[index]),
                getPageInfo: (data) => data.taxiOrders.pageInfo.offsetPageInfo,
                data: state.activeOrdersState,
                onPageChanged: (page) =>
                    bloc.add(TaxiOverviewEvent.activeOrdersPageChanged(page)),
                paging: state.activeOrdersPaging,
              ),
            ),
          ],
        );
      },
    );
  }

  DataRow _rowBuilder(BuildContext context, Fragment$taxiOrderListItem node) {
    return DataRow(
      onSelectChanged: (value) {
        context.router.navigate(
          TaxiShellRoute(
            children: [
              TaxiOrderShellRoute(
                children: [TaxiOrderDetailRoute(orderId: node.id)],
              ),
            ],
          ),
        );
      },
      cells: [
        DataCell(
          Text(
            "#${node.id}",
            style: context.textTheme.labelMedium?.variant(context),
          ),
        ),
        DataCell(
          AppProfileCell(
            name: node.rider.fullName ?? "N/A",
            imageUrl: node.rider.imageUrl,
            subtitle: node.rider.mobileNumber.formatPhoneNumber(null),
          ),
        ),
        DataCell(
          Text(
            node.createdAt.formatDateTime,
            style: context.textTheme.labelMedium?.variant(context),
          ),
        ),
        DataCell(node.status.chip(context)),
        DataCell(
          AppProfileCell(
            name: node.driver?.fullName ?? context.tr.searching,
            imageUrl: node.driver?.imageUrl,
            subtitle: node.driver?.mobileNumber.formatPhoneNumber(null),
          ),
        ),
      ],
    );
  }
}
