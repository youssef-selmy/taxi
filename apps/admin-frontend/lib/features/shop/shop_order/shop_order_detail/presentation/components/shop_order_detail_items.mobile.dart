import 'package:admin_frontend/config/env.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/blocs/shop_order_detail.cubit.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/dialogs/shop_order_detail_remove_item_dialog.dart';
import 'package:better_icons/better_icons.dart';

class ShopOrderDetailItemsMobile extends StatelessWidget {
  const ShopOrderDetailItemsMobile({super.key, required this.cart});

  final Fragment$orderShopDetail$carts cart;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopOrderDetailBloc, ShopOrderDetailState>(
      builder: (context, state) {
        final order = state.shopOrderDetailState.data;
        return Column(
          children: cart.products
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: item.itemVariant?.product.image?.widget(
                                  width: 106,
                                  height: 106,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.itemVariant?.product.name ?? "-",
                                    style: context.textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '${item.priceEach.formatCurrency(order?.currency ?? Env.defaultCurrency)}  x  ${item.quantity.toStringAsFixed(0)}',
                                        style: context.textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                (item.priceEach * item.quantity).formatCurrency(
                                  order?.currency ?? Env.defaultCurrency,
                                ),
                                style: context.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          CupertinoButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                useSafeArea: false,
                                builder: (context) {
                                  return ShopOrderDetailRemoveItemDialog(
                                    cartId: cart.id,
                                    item: item,
                                    currency:
                                        order?.currency ?? Env.defaultCurrency,
                                  );
                                },
                              );
                            },
                            child: Icon(
                              BetterIcons.delete03Outline,
                              size: 20,
                              color: context.colors.error,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.tr.variant,
                            style: context.textTheme.labelMedium?.variant(
                              context,
                            ),
                          ),
                          Text(
                            item.itemVariant?.name ?? "-",
                            style: context.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: item.options.map((option) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                option.name,
                                style: context.textTheme.labelMedium?.variant(
                                  context,
                                ),
                              ),
                              Text(
                                '+ ${option.price.formatCurrency(order?.currency ?? Env.defaultCurrency)}',
                                style: context.textTheme.labelMedium?.copyWith(
                                  color: context.colors.primary,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
