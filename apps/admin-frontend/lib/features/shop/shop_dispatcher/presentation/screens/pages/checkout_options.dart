import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/shop_dispatcher.cubit.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/address_info.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/cart/cart.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/customer_profile.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/delivery_method/delivery_methods.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/payment_methods/payment_methods.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/wallet_balance.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/screens/dialogs/confirm_order.dart';
import 'package:better_icons/better_icons.dart';

class CheckoutOptions extends StatelessWidget {
  const CheckoutOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              CustomerProfile(),
              SizedBox(width: 8),
              Expanded(child: AddressInfo()),
              WalletBalance(),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          context.tr.selectDeliveryMethod,
                          style: context.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        const DeliveryMethods(),
                        const SizedBox(height: 24),
                        Text(
                          context.tr.choosePaymentMethod,
                          style: context.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        const PaymentMethods(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Cart(summaryType: CartSummaryType.full),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.colors.outline),
            color: context.colors.surface,
            boxShadow: kBottomBarShadow(context),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              AppOutlinedButton(
                prefixIcon: BetterIcons.arrowLeft02Outline,
                onPressed: context.read<ShopDispatcherBloc>().goBack,
                text: context.tr.back,
              ),
              const Spacer(),
              BlocBuilder<ShopDispatcherBloc, ShopDispatcherState>(
                builder: (context, state) {
                  return AppFilledButton(
                    isDisabled: state.carts.isEmpty,
                    onPressed: () {
                      showDialog(
                        context: context,
                        useSafeArea: false,
                        builder: (context) {
                          return const ConfirmOrder();
                        },
                      );
                    },
                    text: context.tr.completePurchase,
                    suffixIcon: BetterIcons.arrowRight02Outline,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
