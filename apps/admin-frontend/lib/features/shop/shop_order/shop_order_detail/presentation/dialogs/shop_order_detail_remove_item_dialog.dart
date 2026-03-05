import 'package:admin_frontend/config/env.dart';
import 'package:flutter/cupertino.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:better_design_system/organisms/responsive_dialog/responsive_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/customer.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/blocs/shop_order_detail.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ShopOrderDetailRemoveItemDialog extends StatelessWidget {
  const ShopOrderDetailRemoveItemDialog({
    super.key,
    required this.item,
    required this.currency,
    required this.cartId,
  });

  final String cartId;
  final String currency;
  final Fragment$shopOrderCartItem item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopOrderDetailBloc(),
      child: BlocBuilder<ShopOrderDetailBloc, ShopOrderDetailState>(
        builder: (context, state) {
          final shopOrder = state.shopOrderDetailState.data;
          return AppResponsiveDialog(
            primaryButton: AppFilledButton(
              color: SemanticColor.error,
              onPressed: () {
                context.read<ShopOrderDetailBloc>().shopOrderDetailRemoveItem(
                  Input$RemoveItemFromCartInput(
                    cartId: cartId,
                    cancelables: [
                      Input$RemoveItemFromCartItemQuantityPair(
                        shopOrderCartItemId: item.id,
                        cancelQuantity: item.quantity,
                      ),
                    ],
                  ),
                );
                context.router.maybePop();
              },
              text: context.tr.yesImSure,
            ),
            secondaryButton: AppOutlinedButton(
              onPressed: () {
                context.router.maybePop();
              },
              text: context.tr.cancel,
              color: SemanticColor.neutral,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            maxWidth: 648,
            icon: BetterIcons.delete03Filled,
            title: context.tr.areYouSureRemoveItem,
            iconColor: SemanticColor.error,
            onClosePressed: () {
              context.router.maybePop();
            },
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          AppAvatar(
                            imageUrl: shopOrder?.customer.media?.address,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                context.tr.customer,
                                style: context.textTheme.labelMedium?.variant(
                                  context,
                                ),
                              ),
                              Text(
                                shopOrder?.customer.fullName ?? '',
                                style: context.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              border: kBorder(context),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Icon(
                                BetterIcons.wallet01Filled,
                                color: context.colors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                context.tr.willReturnToCustomerWallet,
                                style: context.textTheme.labelMedium?.variant(
                                  context,
                                ),
                              ),
                              (item.priceEach * item.quantity).toCurrency(
                                context,
                                currency,
                                colored: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          if (item.itemVariant != null)
                            item.itemVariant!.product.image.widget(
                              width: 40,
                              height: 40,
                            ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Item',
                                style: context.textTheme.labelMedium?.variant(
                                  context,
                                ),
                              ),
                              Text(
                                item.itemVariant?.product.name ?? "-",
                                style: context.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              border: kBorder(context),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Center(
                              child: Icon(
                                BetterIcons.wallet01Filled,
                                color: context.colors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                context.tr.willBeDeductedFromItem,
                                style: context.textTheme.labelMedium?.variant(
                                  context,
                                ),
                              ),
                              (-item.priceEach * item.quantity).toCurrency(
                                context,
                                shopOrder?.currency ?? Env.defaultCurrency,
                                colored: true,
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    context.tr.removeItemConfirmation,
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
