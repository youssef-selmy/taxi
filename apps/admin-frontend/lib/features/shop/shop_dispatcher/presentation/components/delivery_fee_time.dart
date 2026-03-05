import 'package:flutter/cupertino.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.dart';
import 'package:better_icons/better_icons.dart';

class DeliveryFeeTime extends StatelessWidget {
  final Fragment$DispatcherShop shop;

  const DeliveryFeeTime({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          BetterIcons.deliveryBox01Filled,
          color: context.colors.onSurfaceVariant,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          shop.deliveryFee.formatCurrency(shop.currency),
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 10),
        Icon(
          BetterIcons.truckDeliveryFilled,
          color: context.colors.onSurfaceVariant,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          "${shop.minDeliveryTime.toString()} - ${shop.maxDeliveryTime.toString()} min",
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
