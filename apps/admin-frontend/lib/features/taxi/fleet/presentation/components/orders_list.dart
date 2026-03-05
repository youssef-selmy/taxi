import 'package:admin_frontend/core/graphql/fragments/driver.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/payment_method.dart';
import 'package:admin_frontend/core/enums/taxi_order_sort_field.dart';
import 'package:admin_frontend/core/enums/taxi_order_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_orders.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/blocs/fleet_order.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({super.key});

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FleetOrderBloc>();
    return BlocListener<FleetOrderBloc, FleetOrderState>(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(context.tr.ordersList, style: context.textTheme.bodyMedium),
              const Spacer(),
              AppFilledButton(
                prefixIcon: BetterIcons.share08Outline,
                text: context.tr.export,
                onPressed: () {
                  bloc.export(Enum$ExportFormat.CSV);
                },
              ),
              const SizedBox(width: 8),
              AppOutlinedButton(
                text: context.tr.print,
                onPressed: () {
                  bloc.export(Enum$ExportFormat.PDF);
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<FleetOrderBloc, FleetOrderState>(
              builder: (context, state) {
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
                  sortOptions: AppSortDropdown(
                    selectedValues: state.sortFields,
                    onChanged: bloc.onSortingChanged,
                    items: [
                      Input$OrderSort(
                        field: Enum$OrderSortFields.id,
                        direction: Enum$SortDirection.ASC,
                      ),
                      Input$OrderSort(
                        field: Enum$OrderSortFields.id,
                        direction: Enum$SortDirection.DESC,
                      ),
                      Input$OrderSort(
                        field: Enum$OrderSortFields.status,
                        direction: Enum$SortDirection.ASC,
                      ),
                      Input$OrderSort(
                        field: Enum$OrderSortFields.status,
                        direction: Enum$SortDirection.DESC,
                      ),
                      Input$OrderSort(
                        field: Enum$OrderSortFields.costBest,
                        direction: Enum$SortDirection.ASC,
                      ),
                      Input$OrderSort(
                        field: Enum$OrderSortFields.costBest,
                        direction: Enum$SortDirection.DESC,
                      ),
                      Input$OrderSort(
                        field: Enum$OrderSortFields.paymentMode,
                        direction: Enum$SortDirection.ASC,
                      ),
                      Input$OrderSort(
                        field: Enum$OrderSortFields.paymentMode,
                        direction: Enum$SortDirection.DESC,
                      ),
                    ],
                    labelGetter: (sort) =>
                        sort.field.tableViewSortLabel(context, sort.direction),
                  ),
                  filterOptions: [
                    AppFilterDropdown<Enum$OrderStatus>(
                      title: context.tr.status,
                      selectedValues: state.orderStatusFilter,
                      onChanged: bloc.onStatusChanged,
                      items: Enum$OrderStatus.values
                          .where((e) => e != Enum$OrderStatus.$unknown)
                          .map(
                            (status) => FilterItem(
                              label: status.name(context),
                              value: status,
                            ),
                          )
                          .toList(),
                    ),
                    AppFilterDropdown<Enum$PaymentMode>(
                      title: context.tr.paymentMethod,
                      selectedValues: state.paymentMethodFilter,
                      onChanged: bloc.onPaymentModeChanged,
                      items: Enum$PaymentMode.values
                          .where((e) => e != Enum$PaymentMode.$unknown)
                          .map(
                            (paymentMode) => FilterItem(
                              label: paymentMode.name(context),
                              value: paymentMode,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                  getRowCount: (data) => data.orders.nodes.length,
                  rowBuilder: rowBuilder,
                  getPageInfo: (data) => data.orders.pageInfo,
                  data: state.fleetOrders,
                  paging: state.paging,
                  onPageChanged: bloc.onPageChanged,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  DataRow rowBuilder(Query$fleetOrders data, int index) {
    final order = data.orders.nodes[index];
    return DataRow(
      onSelectChanged: (value) {
        context.navigateTo(
          TaxiOrderShellRoute(
            children: [
              TaxiOrderListRoute(
                children: [TaxiOrderDetailRoute(orderId: order.id)],
              ),
            ],
          ),
        );
      },
      cells: [
        DataCell(order.driver?.tableView(context) ?? Text("N/A")),
        DataCell(
          Text(
            order.createdOn.formatDateTime,
            style: context.textTheme.labelMedium,
          ),
        ),
        DataCell(order.costAfterCoupon.toCurrency(context, order.currency)),
        DataCell(
          order.paymentMode?.tableViewPaymentMethod(
                context,
                order.savedPaymentMethod,
                order.paymentGateway,
              ) ??
              Text(context.tr.unknown),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              order.addresses.join(',\n'),
              style: context.textTheme.labelMedium?.variant(context),
            ),
          ),
        ),
        DataCell(order.status.chip(context)),
      ],
    );
  }
}
