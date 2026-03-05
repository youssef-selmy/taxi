import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/blocs/shop_order_detail.cubit.dart';

class ShopOrderDetailPaymentMethod extends StatelessWidget {
  const ShopOrderDetailPaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopOrderDetailBloc, ShopOrderDetailState>(
      builder: (context, state) {
        final order = state.shopOrderDetailState.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${context.tr.paymentMethod}:',
              style: context.textTheme.labelMedium?.variant(context),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: kBorder(context),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: state
                        .shopOrderDetailState
                        .data
                        ?.paymentGateway
                        ?.media
                        ?.widget(width: 32, height: 32),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  order?.paymentGateway?.title ?? '',
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
