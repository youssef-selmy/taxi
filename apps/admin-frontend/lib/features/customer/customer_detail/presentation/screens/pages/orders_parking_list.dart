import 'package:api_response/api_response.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/parking_order_sort_field.dart';
import 'package:admin_frontend/core/enums/parking_order_status.dart';
import 'package:admin_frontend/core/enums/payment_method.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/orders_parking.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/blocs/orders_parking.cubit.dart';
import 'package:admin_frontend/features/dashboard/presentation/blocs/dashboard.cubit.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrdersParkingList extends StatelessWidget {
  final String customerId;

  const OrdersParkingList({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrdersParkingBloc()..onStarted(customerId: customerId),
      child: BlocConsumer<OrdersParkingBloc, OrdersParkingState>(
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    context.tr.parkingOrders,
                    style: context.textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  AppFilledButton(
                    prefixIcon: BetterIcons.share08Outline,
                    text: context.tr.export,
                    onPressed: () {
                      context.read<OrdersParkingBloc>().export(
                        Enum$ExportFormat.CSV,
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  AppOutlinedButton(
                    text: context.tr.print,
                    onPressed: () {
                      context.read<OrdersParkingBloc>().export(
                        Enum$ExportFormat.PDF,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: BlocBuilder<OrdersParkingBloc, OrdersParkingState>(
                  builder: (context, state) {
                    return AppDataTable(
                      columns: [
                        DataColumn(label: Text(context.tr.parking)),
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
                        selectedValues: state.sorting,
                        onChanged: context
                            .read<OrdersParkingBloc>()
                            .onSortingChanged,
                        items: [
                          Input$ParkOrderSort(
                            field: Enum$ParkOrderSortFields.id,
                            direction: Enum$SortDirection.ASC,
                          ),
                          Input$ParkOrderSort(
                            field: Enum$ParkOrderSortFields.id,
                            direction: Enum$SortDirection.DESC,
                          ),
                          Input$ParkOrderSort(
                            field: Enum$ParkOrderSortFields.status,
                            direction: Enum$SortDirection.ASC,
                          ),
                          Input$ParkOrderSort(
                            field: Enum$ParkOrderSortFields.status,
                            direction: Enum$SortDirection.DESC,
                          ),
                          Input$ParkOrderSort(
                            field: Enum$ParkOrderSortFields.price,
                            direction: Enum$SortDirection.ASC,
                          ),
                          Input$ParkOrderSort(
                            field: Enum$ParkOrderSortFields.price,
                            direction: Enum$SortDirection.DESC,
                          ),
                          Input$ParkOrderSort(
                            field: Enum$ParkOrderSortFields.paymentMode,
                            direction: Enum$SortDirection.ASC,
                          ),
                          Input$ParkOrderSort(
                            field: Enum$ParkOrderSortFields.paymentMode,
                            direction: Enum$SortDirection.DESC,
                          ),
                        ],
                        labelGetter: (sort) => sort.field.tableViewSortLabel(
                          context,
                          sort.direction,
                        ),
                      ),
                      filterOptions: [
                        AppFilterDropdown<Enum$ParkOrderStatus>(
                          title: context.tr.status,
                          selectedValues: state.statuses,
                          onChanged: context
                              .read<OrdersParkingBloc>()
                              .onStatusChanged,
                          items: Enum$ParkOrderStatus.values
                              .where((e) => e != Enum$ParkOrderStatus.$unknown)
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
                          selectedValues: state.paymentModes,
                          onChanged: context
                              .read<OrdersParkingBloc>()
                              .onPaymentModeChanged,
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
                      getRowCount: (data) => data.parkOrders.nodes.length,
                      rowBuilder: (data, index) =>
                          rowBuilder(context, data, index),
                      getPageInfo: (data) => data.parkOrders.pageInfo,
                      data: state.ordersState,
                      paging: state.paging,
                      onPageChanged: context
                          .read<OrdersParkingBloc>()
                          .onPageChanged,
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

  DataRow rowBuilder(
    BuildContext context,
    Query$customerOrdersParking data,
    int index,
  ) {
    final order = data.parkOrders.nodes[index];
    return DataRow(
      onSelectChanged: (value) {
        context.read<DashboardBloc>().goToRoute(ParkingOrderListRoute());
        context.navigateTo(
          ParkingShellRoute(
            children: [
              ParkingOrderShellRoute(
                children: [
                  ParkingOrderShellRoute(
                    children: [
                      ParkingOrderDetailRoute(parkingOrderId: order.id),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
      cells: [
        DataCell(order.parkSpot.tableView(context)),
        DataCell(
          Text(
            order.createdAt.formatDateTime,
            style: context.textTheme.labelMedium?.variant(context),
          ),
        ),
        DataCell(order.price.toCurrency(context, order.currency)),
        DataCell(
          order.paymentMode.tableViewPaymentMethod(
            context,
            order.savedPaymentMethod,
            order.paymentGateway,
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              order.parkSpot.address ?? context.tr.unknown,
              style: context.textTheme.labelMedium?.variant(context),
            ),
          ),
        ),
        DataCell(order.status.toChip(context)),
      ],
    );
  }
}
