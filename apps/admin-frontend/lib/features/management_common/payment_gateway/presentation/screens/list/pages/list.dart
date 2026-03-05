import 'package:admin_frontend/config/env.dart';
import 'package:better_design_system/atoms/badge/badge.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/data_table/data_table.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/management_common/payment_gateway/data/graphql/payment_gateway.graphql.dart';
import 'package:admin_frontend/features/management_common/payment_gateway/presentation/blocs/payment_gateway_list.cubit.dart';

class PaymentGatewaysListPage extends StatelessWidget {
  const PaymentGatewaysListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PaymentGatewayListBloc>();
    return BlocBuilder<PaymentGatewayListBloc, PaymentGatewayListState>(
      builder: (context, state) {
        return AppDataTable(
          columns: [
            DataColumn(label: Text(context.tr.name)),
            DataColumn(label: Text(context.tr.processedAmount)),
          ],
          getRowCount: (data) => data.paymentGateways.nodes.length,
          rowBuilder: (data, index) => _rowBuilder(context, data, index),
          getPageInfo: (data) => data.paymentGateways.pageInfo,
          data: state.paymentGateways,
          paging: state.paging,
          onPageChanged: bloc.onPageChanged,
        );
      },
    );
  }

  DataRow _rowBuilder(
    BuildContext context,
    Query$paymentGateways data,
    int index,
  ) {
    final paymentGateway = data.paymentGateways.nodes[index];
    return DataRow(
      cells: [
        DataCell(
          Row(
            spacing: 8,
            children: [
              if (paymentGateway.media != null)
                CachedNetworkImage(
                  imageUrl: paymentGateway.media!.address,
                  width: 32,
                  height: 32,
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.image_not_supported),
                ),
              Text(paymentGateway.title),
              if (!paymentGateway.enabled)
                AppBadge(text: context.tr.disabled, color: SemanticColor.error),
            ],
          ),
        ),
        DataCell(
          (paymentGateway.totalTransactions.firstOrNull?.sum?.amount ?? 0)
              .toCurrency(
                context,
                paymentGateway
                        .totalTransactions
                        .firstOrNull
                        ?.groupBy
                        ?.currency ??
                    Env.defaultCurrency,
              ),
        ),
      ],
      onSelectChanged: (_) async {
        final bloc = context.read<PaymentGatewayListBloc>();
        await context.router.push(
          PaymentGatewayDetailsRoute(paymentGatewayId: paymentGateway.id),
        );
        bloc.refresh();
      },
    );
  }
}
