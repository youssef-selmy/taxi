import 'package:admin_frontend/core/graphql/documents/taxi_orders.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/payment_method.extensions.dart';
import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/taxi_order_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/blocs/orders_taxi.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrdersTaxiList extends StatelessWidget {
  final String customerId;

  const OrdersTaxiList({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersTaxiBloc()..onStarted(customerId: customerId),
      child: BlocConsumer<OrdersTaxiBloc, OrdersTaxiState>(
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    context.tr.taxiOrders,
                    style: context.textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  AppFilledButton(
                    prefixIcon: BetterIcons.share08Outline,
                    text: context.tr.export,
                    onPressed: () {
                      context.read<OrdersTaxiBloc>().export(
                        Enum$ExportFormat.CSV,
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  AppOutlinedButton(
                    text: context.tr.print,
                    onPressed: () {
                      context.read<OrdersTaxiBloc>().export(
                        Enum$ExportFormat.PDF,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: BlocBuilder<OrdersTaxiBloc, OrdersTaxiState>(
                  builder: (context, state) {
                    final bloc = context.read<OrdersTaxiBloc>();
                    return AppDataTable(
                      columns: [
                        DataColumn(label: Text(context.tr.driver)),
                        DataColumn2(
                          label: Text(context.tr.dateAndTime),
                          size: ColumnSize.S,
                        ),
                        DataColumn2(
                          label: Text(context.tr.cost),
                          size: ColumnSize.S,
                        ),
                        DataColumn(label: Text(context.tr.paymentMethod)),
                        DataColumn(label: Text(context.tr.locations)),
                        DataColumn2(
                          label: Text(context.tr.status),
                          size: ColumnSize.S,
                        ),
                      ],
                      filterOptions: [],
                      getRowCount: (data) => data.taxiOrders.edges.length,
                      rowBuilder: (data, index) =>
                          rowBuilder(context, data, index),
                      getPageInfo: (data) => Fragment$OffsetPageInfo(
                        hasNextPage: data.taxiOrders.pageInfo.hasNextPage,
                        hasPreviousPage:
                            data.taxiOrders.pageInfo.hasPreviousPage,
                      ),
                      data: state.ordersState,
                      paging: Input$OffsetPaging(
                        limit: state.paging?.first,
                        offset: state.paging?.after,
                      ),
                      onPageChanged: bloc.onPageChanged,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  DataRow rowBuilder(BuildContext context, Query$taxiOrders data, int index) {
    final order = data.taxiOrders.edges[index];
    return DataRow(
      onSelectChanged: (value) {
        context.navigateTo(
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
        DataCell(order.nameView(context)),
        DataCell(
          Text(
            order.createdAt.formatDateTime,
            style: context.textTheme.labelMedium,
          ),
        ),
        DataCell(order.totalCost.toCurrency(context, order.currency)),
        DataCell(order.paymentMethod.tableViewPaymentMethod(context)),
        DataCell(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              order.waypoints.map((e) => e.address).join(',\n'),
              style: context.textTheme.labelMedium?.variant(context),
            ),
          ),
        ),
        DataCell(order.status.chip(context)),
      ],
    );
  }
}
