import 'package:admin_frontend/config/env.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/enums/delivery_method_enum.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/blocs/shop_order_detail.cubit.dart';

class ShopOrderDetailDeliveryType extends StatelessWidget {
  const ShopOrderDetailDeliveryType({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopOrderDetailBloc, ShopOrderDetailState>(
      builder: (context, state) {
        final order = state.shopOrderDetailState.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '${context.tr.deliveryType}:',
              style: context.textTheme.labelMedium?.variant(context),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order?.deliveryMethod.name(context) ?? "-",
                  style: context.textTheme.bodyMedium,
                ),
                context.responsive(const SizedBox(width: 32)),
                Text(
                  (order?.deliveryFee ?? 0).formatCurrency(
                    order?.currency ?? Env.defaultCurrency,
                  ),
                  style: context.textTheme.bodyMedium?.apply(
                    color: context.colors.primary,
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
