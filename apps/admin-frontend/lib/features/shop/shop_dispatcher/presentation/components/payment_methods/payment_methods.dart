import 'package:better_design_system/entities/payment_method.entity.dart';
import 'package:better_design_system/molecules/list_item/list_item.dart';
import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:admin_frontend/core/enums/saved_payment_method_provider_brand.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/saved_payment_method.graphql.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/shop_dispatcher.cubit.dart';
import 'package:better_icons/better_icons.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopDispatcherBloc, ShopDispatcherState>(
      builder: (context, state) {
        return switch (state.checkoutOptions) {
          ApiResponseInitial() => const SizedBox(),
          ApiResponseLoading() => const SizedBox(),
          ApiResponseError(:final message) => Text(message),
          ApiResponseLoaded(:final data) => AlignedGridView.count(
            itemCount: (data.savedPaymentMethods.nodes.length) + 2,
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemBuilder: (context, index) {
              if (index == 0) {
                return AppListItem(
                  title: context.tr.wallet,
                  isSelected:
                      state.paymentMethod?.type ==
                      PaymentMethodType.walletCredit,
                  trailing: Icon(
                    BetterIcons.wallet01Filled,
                    color: context.colors.primary,
                  ),
                  onTap: (value) => context
                      .read<ShopDispatcherBloc>()
                      .onPaymentMethodSelected,
                );
              } else if (index == 1) {
                return AppListItem(
                  title: context.tr.cash,
                  isSelected:
                      state.paymentMethod?.type == PaymentMethodType.cash,
                  trailing: Icon(
                    BetterIcons.money03Filled,
                    color: context.colors.primary,
                  ),
                  onTap: (value) => context
                      .read<ShopDispatcherBloc>()
                      .onPaymentMethodSelected,
                );
              } else {
                final Fragment$SavedPaymentMethod paymentMethod =
                    data.savedPaymentMethods.nodes[index - 2];
                return AppListItem(
                  title: paymentMethod.title,
                  isDisabled:
                      state.paymentMethod?.id == paymentMethod.id &&
                      state.paymentMethod?.type == PaymentMethodType.savedCard,
                  trailing: paymentMethod.providerBrand?.image.image(
                    width: 24,
                    height: 24,
                  ),
                  onTap: (value) => context
                      .read<ShopDispatcherBloc>()
                      .onPaymentMethodSelected,
                );
              }
            },
          ),
        };
      },
    );
  }
}
