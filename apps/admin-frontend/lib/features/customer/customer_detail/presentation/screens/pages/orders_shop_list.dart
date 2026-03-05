import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_icons/better_icon.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/enums/payment_method.dart';
import 'package:admin_frontend/core/enums/shop_order_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/address.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.extensions.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/orders_shop.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/blocs/orders_shop.cubit.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrdersShopList extends StatelessWidget {
  final String customerId;

  const OrdersShopList({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersShopBloc()..onStarted(customerId: customerId),
      child: BlocConsumer<OrdersShopBloc, OrdersShopState>(
        listenWhen: (_, state) =>
            state.exportState is ApiResponseLoaded ||
            state.exportState is ApiResponseError,
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
                    context.tr.shopOrders,
                    style: context.textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  AppFilledButton(
                    onPressed: () {
                      context.read<OrdersShopBloc>().export(
                        Enum$ExportFormat.CSV,
                      );
                    },
                    prefixIcon: BetterIcons.share08Outline,
                    text: context.tr.export,
                  ),
                  const SizedBox(width: 8),
                  AppOutlinedButton(
                    onPressed: () {
                      context.read<OrdersShopBloc>().export(
                        Enum$ExportFormat.PDF,
                      );
                    },
                    text: context.tr.print,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: AppDataTable(
                  columns: [
                    DataColumn(label: Text(context.tr.shop)),
                    DataColumn2(
                      label: Text(context.tr.dateAndTime),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Text(context.tr.cost),
                      size: ColumnSize.S,
                    ),
                    DataColumn(label: Text(context.tr.paymentMethod)),
                    DataColumn(label: Text(context.tr.deliveryLocation)),
                    DataColumn2(
                      label: Text(context.tr.status),
                      size: ColumnSize.S,
                    ),
                  ],
                  getRowCount: (data) => data.shopOrders.nodes.length,
                  rowBuilder: (data, index) => rowBuilder(context, data, index),
                  getPageInfo: (data) => data.shopOrders.pageInfo,
                  data: state.ordersState,
                  paging: state.paging,
                  onPageChanged: context.read<OrdersShopBloc>().onPageChanged,
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
    Query$customerOrdersShop data,
    int index,
  ) {
    final order = data.shopOrders.nodes[index];
    return DataRow(
      onSelectChanged: (value) {
        context.navigateTo(
          ShopShellRoute(
            children: [
              ShopOrderShellRoute(
                children: [ShopOrderDetailRoute(shopOrderId: order.id)],
              ),
            ],
          ),
        );
      },
      cells: [
        DataCell(order.carts.map((e) => e.shop).toList().tableView(context)),
        DataCell(
          Text(
            order.createdAt.formatDateTime,
            style: context.textTheme.labelMedium,
          ),
        ),
        DataCell(order.total.toCurrency(context, order.currency)),
        DataCell(
          order.paymentMethod.tableViewPaymentMethod(
            context,
            order.savedPaymentMethod,
            order.paymentGateway,
          ),
        ),
        DataCell(order.deliveryAddress.tableView(context)),
        DataCell(order.status.chip(context)),
      ],
    );
  }
}
