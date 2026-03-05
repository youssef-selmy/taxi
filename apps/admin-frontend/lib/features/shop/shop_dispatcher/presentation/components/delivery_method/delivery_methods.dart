import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/shop_dispatcher.cubit.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/delivery_method/delivery_method_item.dart';
import 'package:admin_frontend/schema.graphql.dart';

class DeliveryMethods extends StatelessWidget {
  const DeliveryMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopDispatcherBloc, ShopDispatcherState>(
      builder: (context, state) {
        return Skeletonizer(
          enabled: state.checkoutOptions.isLoading,
          child: Column(
            children: [
              DeliveryMethodItem(
                deliveryMethod: Enum$DeliveryMethod.BATCH,
                isSelected: state.deliveryMethod == Enum$DeliveryMethod.BATCH,
                price:
                    state
                        .checkoutOptions
                        .data
                        ?.calculateDeliveryFee
                        .batchDeliveryFee ??
                    0,
                currency: state.currency,
                onSelected: context
                    .read<ShopDispatcherBloc>()
                    .onDeliveryMethodSelected,
              ),
              const SizedBox(height: 8),
              DeliveryMethodItem(
                deliveryMethod: Enum$DeliveryMethod.SPLIT,
                price:
                    state
                        .checkoutOptions
                        .data
                        ?.calculateDeliveryFee
                        .splitDeliveryFee ??
                    0,
                isSelected: state.deliveryMethod == Enum$DeliveryMethod.SPLIT,
                currency: state.currency,
                onSelected: context
                    .read<ShopDispatcherBloc>()
                    .onDeliveryMethodSelected,
              ),
              const SizedBox(height: 8),
              DeliveryMethodItem(
                deliveryMethod: Enum$DeliveryMethod.SCHEDULED,
                price:
                    state
                        .checkoutOptions
                        .data
                        ?.calculateDeliveryFee
                        .batchDeliveryFee ??
                    0,
                isSelected:
                    state.deliveryMethod == Enum$DeliveryMethod.SCHEDULED,
                currency: state.currency,
                onSelected: context
                    .read<ShopDispatcherBloc>()
                    .onDeliveryMethodSelected,
              ),
            ],
          ),
        );
      },
    );
  }
}
