import 'package:admin_frontend/config/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/blocs/taxi_order_detail.bloc.dart';

class TaxiOrderSummarySection extends StatelessWidget {
  const TaxiOrderSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxiOrderDetailBloc, TaxiOrderDetailState>(
      builder: (context, state) {
        final order = state.orderDetailResponse.data;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.tr.summary, style: context.textTheme.bodyMedium),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    context.tr.subtotal,
                    style: context.textTheme.bodySmall?.variant(context),
                  ),
                ),
                Text(
                  (order?.totalCost ?? 0).formatCurrency(
                    order?.currency ?? Env.defaultCurrency,
                  ),
                  style: context.textTheme.labelMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    context.tr.feesAndTax,
                    style: context.textTheme.bodySmall?.variant(context),
                  ),
                ),
                Text(
                  (0.0).formatCurrency(order?.currency ?? Env.defaultCurrency),
                  style: context.textTheme.labelMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    context.tr.rideOptions,
                    style: context.textTheme.bodySmall?.variant(context),
                  ),
                ),
                Text(
                  (0.0).formatCurrency(order?.currency ?? Env.defaultCurrency),
                  style: context.textTheme.labelMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    '${context.tr.waitCost} (${context.tr.waitMinute} : ${order?.waitMinutes?.toStringAsFixed(0) ?? 0})',
                    style: context.textTheme.bodySmall?.variant(context),
                  ),
                ),
                Text(
                  (0.0).formatCurrency(order?.currency ?? Env.defaultCurrency),
                  style: context.textTheme.labelMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    context.tr.couponDiscount,
                    style: context.textTheme.labelMedium?.apply(
                      color: context.colors.success,
                    ),
                  ),
                ),
                // if (order != null)
                //   (order.costBest - order.costAfterCoupon).toCurrency(
                //     context,
                //     order.currency,
                //     colored: true,
                //   ),
                if (order != null)
                  Text(
                    (order.couponDiscount ?? 0).formatCurrency(order.currency),
                    style: context.textTheme.labelMedium?.copyWith(
                      color: (order.couponDiscount) != null
                          ? context.colors.success
                          : context.colors.onSurface,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    context.tr.total,
                    style: context.textTheme.bodyMedium,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: (order?.totalCost ?? 0).formatCurrency(
                          order?.currency ?? Env.defaultCurrency,
                        ),
                        style: context.textTheme.bodyMedium,
                      ),
                      TextSpan(
                        text: " ${order?.currency}",
                        style: context.textTheme.bodyMedium?.variant(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
