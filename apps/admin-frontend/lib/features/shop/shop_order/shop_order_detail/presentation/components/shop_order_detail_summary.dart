import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/blocs/shop_order_detail.cubit.dart';

class ShopOrderDetailSummarySection extends StatelessWidget {
  const ShopOrderDetailSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopOrderDetailBloc, ShopOrderDetailState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.tr.summary, style: context.textTheme.bodyMedium),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    context.tr.subtotal,
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
                  Text(
                    (state.shopOrderDetailState.data?.subTotal ?? 0)
                        .formatCurrency(
                          state.shopOrderDetailState.data?.currency ?? '',
                        ),
                    style: context.textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    context.tr.deliveryFee,
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
                  Text(
                    (state.shopOrderDetailState.data?.deliveryFee ?? 0)
                        .formatCurrency(
                          state.shopOrderDetailState.data?.currency ?? '',
                        ),
                    style: context.textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    context.tr.tax,
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
                  Text(
                    (state.shopOrderDetailState.data?.tax ?? 0).formatCurrency(
                      state.shopOrderDetailState.data?.currency ?? '',
                    ),
                    style: context.textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    context.tr.discount,
                    style: context.textTheme.labelMedium?.apply(
                      color: context.colors.success,
                    ),
                  ),
                  Text(
                    (state.shopOrderDetailState.data?.discount ?? 0)
                        .formatCurrency(
                          state.shopOrderDetailState.data?.currency ?? '',
                        ),
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colors.success,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(context.tr.total, style: context.textTheme.bodyMedium),
                  Text(
                    (state.shopOrderDetailState.data?.total ?? 0)
                        .formatCurrency(
                          state.shopOrderDetailState.data?.currency ?? '',
                        ),
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
