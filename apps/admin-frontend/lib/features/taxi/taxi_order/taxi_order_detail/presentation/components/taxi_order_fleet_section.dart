import 'package:admin_frontend/core/graphql/fragments/payment_method.extensions.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/enums/payment_method.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/blocs/taxi_order_detail.bloc.dart';

class TaxiOrderFleetSection extends StatelessWidget {
  const TaxiOrderFleetSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxiOrderDetailBloc, TaxiOrderDetailState>(
      builder: (context, state) {
        final order = state.orderDetailResponse.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              context.tr.fleet,
              style: context.textTheme.labelMedium?.variant(context),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                AppAvatar(
                  imageUrl: order?.fleet?.imageUrl,
                  size: AvatarSize.size40px,
                ),
                const SizedBox(width: 8),
                Text(
                  order?.fleet?.name ?? '',
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              context.tr.paymentMethod,
              style: context.textTheme.labelMedium?.variant(context),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: context.colors.outline),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: order?.paymentMethod.tableViewPaymentMethod(context),
                ),
                const SizedBox(width: 8),
                Text(
                  order?.paymentMethod.mode.name(context) ?? '',
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
