import 'package:admin_frontend/config/env.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/config/theme/shadows.dart';
import 'package:admin_frontend/core/enums/shop_order_status.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/blocs/shop_order_detail.cubit.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/components/shop_order_detail_items.desktop.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/components/shop_order_detail_items.mobile.dart';

class ShopOrderDetailItems extends StatelessWidget {
  const ShopOrderDetailItems({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopOrderDetailBloc, ShopOrderDetailState>(
      builder: (context, state) {
        final order = state.shopOrderDetailState.data;
        return Column(
          children:
              (order?.carts ??
                      List.generate(
                        2,
                        (item) => mockOrderShopDetail.carts.first,
                      ))
                  .map(
                    (cart) => Theme(
                      data: context.theme.copyWith(
                        dividerColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                        expandedAlignment: Alignment.centerLeft,
                        title: Column(
                          children: [
                            Row(
                              children: [
                                if (cart.shop.image != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: cart.shop.image.widget(
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                const SizedBox(width: 10),
                                Expanded(child: Text(cart.shop.name)),
                                if (order != null) order.status.chip(context),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: cart.products.map((item) {
                                return Row(
                                  children: <Widget>[
                                    Stack(
                                      children: [
                                        const SizedBox(height: 55, width: 55),
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: kBorder(context),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            clipBehavior: Clip.hardEdge,
                                            child: item
                                                .itemVariant
                                                ?.product
                                                .image
                                                .widget(width: 48, height: 48),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: kBorder(context),
                                              color: context.colors.surface,
                                            ),
                                            child: Center(
                                              child: Text(
                                                item.quantity.toStringAsFixed(
                                                  0,
                                                ),
                                                style: context
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                );
                              }).toList(),
                            ),
                            Text(
                              (cart.products.fold(
                                0.0,
                                (previousValue, element) =>
                                    (previousValue + element.priceEach) *
                                    element.quantity,
                              )).formatCurrency(
                                order?.currency ?? Env.defaultCurrency,
                              ),
                              style: context.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        children: [
                          context.responsive(
                            ShopOrderDetailItemsMobile(cart: cart),
                            lg: ShopOrderDetailItemsDesktop(cart: cart),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList()
                  .separated(separator: const Divider(height: 16)),
        );
      },
    );
  }
}
