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
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/blocs/shop_order_detail.cubit.dart';
import 'package:better_icons/better_icons.dart';
import 'package:admin_frontend/schema.graphql.dart';

class ShopOrderDetailCancelOrderDialog extends StatefulWidget {
  const ShopOrderDetailCancelOrderDialog({super.key});

  @override
  State<ShopOrderDetailCancelOrderDialog> createState() =>
      _ShopOrderDetailCancelOrderDialogState();
}

class _ShopOrderDetailCancelOrderDialogState
    extends State<ShopOrderDetailCancelOrderDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopOrderDetailBloc(),
      child: BlocConsumer<ShopOrderDetailBloc, ShopOrderDetailState>(
        listener: (context, state) {},
        builder: (context, state) {
          final shopOrder = state.shopOrderDetailState.data;
          return AppResponsiveDialog(
            secondaryButton: AppOutlinedButton(
              onPressed: () {
                context.router.maybePop();
              },
              text: context.tr.cancel,
              color: SemanticColor.neutral,
            ),
            primaryButton: AppFilledButton(
              color: SemanticColor.error,
              onPressed: () {
                context.read<ShopOrderDetailBloc>().shopOrderDetailCancelOrder(
                  Input$CancelShopOrderCartsInput(
                    cartIds:
                        shopOrder?.carts.map((cart) => cart.id).toList() ?? [],
                  ),
                );
                Navigator.of(context).pop();
              },
              text: context.tr.yesImSure,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            maxWidth: 648,
            icon: BetterIcons.delete03Filled,
            title: context.tr.areYouSureYouWantToCancelThisOrder,
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
                              (shopOrder?.total ?? 0).toCurrency(
                                context,
                                shopOrder?.currency ?? Env.defaultCurrency,
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
                ...shopOrder!.carts.map((cart) {
                  return Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: cart.shop.image.widget(
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      context.tr.shop,
                                      style: context.textTheme.labelMedium
                                          ?.variant(context),
                                    ),
                                    Text(
                                      cart.shop.name,
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
                                      context.tr.willDeductFromShopWallet,
                                      style: context.textTheme.labelMedium
                                          ?.variant(context),
                                    ),
                                    (-cart.products.fold(
                                      0.0,
                                      (previousValue, element) =>
                                          (previousValue + element.priceEach) *
                                          element.quantity,
                                    )).toCurrency(
                                      context,
                                      shopOrder.currency,
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
                      const SizedBox(height: 8),
                    ],
                  );
                }),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    context.tr.cancelOrderConfirmation,
                    style: context.textTheme.labelMedium?.variant(context),
                  ),
                ),
                // const SizedBox(height: 16),
                // Row(
                //   children: <Widget>[
                //     Expanded(
                //       child: AppOutlinedButton(
                //         onPressed: () {
                //           context.router.maybePop();
                //         },
                //         title: context.translate.cancel,
                //         color: SemanticColor.neutral,
                //       ),
                //     ),
                //     const SizedBox(width: 6),
                //     Expanded(
                //       child: AppFilledButton(
                //         color: SemanticColor.error,
                //         onPressed: () {
                //           bloc.shopOrderDetailCancelOrder(shopOrder.id);
                //           context.router.maybePop();
                //         },
                //         text: 'Yes, I’m sure',
                //         size: ButtonSize.medium,
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
