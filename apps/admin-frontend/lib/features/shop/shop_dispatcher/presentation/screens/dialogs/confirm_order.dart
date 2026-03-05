import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/enums/delivery_method_enum.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/shop_dispatcher.cubit.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/address_info.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/cart/cart.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/customer_profile.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/screens/dialogs/order_confirmed.dart';
import 'package:better_icons/better_icons.dart';

class ConfirmOrder extends StatelessWidget {
  const ConfirmOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopDispatcherBloc(),
      child: BlocConsumer<ShopDispatcherBloc, ShopDispatcherState>(
        listenWhen: (previous, current) =>
            previous.isSuccessful != current.isSuccessful &&
            current.isSuccessful,
        listener: (context, state) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            useSafeArea: false,
            builder: (context) {
              return const OrderConfirmed();
            },
          );
        },
        builder: (context, state) {
          return AppResponsiveDialog(
            icon: BetterIcons.creditCardFilled,
            title: context.tr.confirmOrder,
            subtitle: context.tr.pleaseConfirmYourOrder,
            primaryButton: AppFilledButton(
              isLoading: state.networkState.isLoading,
              onPressed: () {
                context.read<ShopDispatcherBloc>().onConfirmOrder();
              },
              text: context.tr.confirmOrder,
            ),
            secondaryButton: AppOutlinedButton(
              isDisabled: state.networkState.isLoading,
              onPressed: () {
                Navigator.of(context).pop();
              },
              text: context.tr.cancel,
            ),
            onClosePressed: () {
              Navigator.of(context).pop();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Row(
                  children: [CustomerProfile(), Spacer(), AddressInfo()],
                ),
                const SizedBox(height: 16),
                const Cart(summaryType: CartSummaryType.compact),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            context.tr.deliveryType,
                            style: context.textTheme.labelMedium?.copyWith(
                              color: context.colors.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                state.deliveryMethod.name(context),
                                style: context.textTheme.labelMedium,
                              ),
                              const Spacer(),
                              Text(
                                state.deliveryFee.formatCurrency(
                                  state.currency,
                                ),
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.colors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            context.tr.paymentMethod,
                            style: context.textTheme.labelMedium?.copyWith(
                              color: context.colors.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              state.paymentMethod?.icon(
                                    color: context.colors.primary,
                                  ) ??
                                  const SizedBox(),
                              const SizedBox(width: 8),
                              Text(
                                state.paymentMethod?.title ?? '',
                                style: context.textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
