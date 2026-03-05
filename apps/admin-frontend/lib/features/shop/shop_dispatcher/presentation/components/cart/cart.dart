import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/shop_dispatcher.cubit.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/cart/cart_empty.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/cart/cart_list.dart';
import 'package:better_icons/better_icons.dart';

class Cart extends StatelessWidget {
  final CartSummaryType summaryType;

  const Cart({super.key, this.summaryType = CartSummaryType.none});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.outline),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(
                BetterIcons.creditCardFilled,
                color: context.colors.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                context.tr.shoppingCart,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.onSurface,
                ),
              ),
              const SizedBox(width: 8),
              // sum of all items in all carts
              BlocBuilder<ShopDispatcherBloc, ShopDispatcherState>(
                builder: (context, state) {
                  return Text(
                    "${state.carts.fold<int>(0, (previousValue, element) => previousValue + element.items.length).toString()} ${context.tr.items}",
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (summaryType == CartSummaryType.full) ...[
            _buildCartItems(context),
          ],
          if (summaryType != CartSummaryType.full) ...[
            _buildCartItems(context),
          ],
          if (summaryType == CartSummaryType.compact) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Text(context.tr.total, style: context.textTheme.bodyMedium),
                const Spacer(),
                BlocBuilder<ShopDispatcherBloc, ShopDispatcherState>(
                  builder: (context, state) {
                    return Text(
                      state.total.formatCurrency(state.currency),
                      style: context.textTheme.bodyMedium,
                    );
                  },
                ),
              ],
            ),
          ],
          if (summaryType == CartSummaryType.full) ...[
            BlocBuilder<ShopDispatcherBloc, ShopDispatcherState>(
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      context.tr.summary,
                      style: context.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),
                    // subtotal
                    Row(
                      children: [
                        Text(
                          context.tr.subtotal,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          state.subtotal.formatCurrency(state.currency),
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // delivery fee
                    Row(
                      children: [
                        Text(
                          context.tr.deliveryFee,
                          style: context.textTheme.labelMedium?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          state.deliveryFee.formatCurrency(state.currency),
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // total
                    Row(
                      children: [
                        Text(
                          context.tr.total,
                          style: context.textTheme.bodyMedium,
                        ),
                        const Spacer(),
                        Text(
                          state.total.formatCurrency(state.currency),
                          style: context.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCartItems(BuildContext context) {
    return BlocBuilder<ShopDispatcherBloc, ShopDispatcherState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: kThemeAnimationDuration,
          child: state.carts.isEmpty
              ? const CartEmpty()
              : CartList(carts: state.carts),
        );
      },
    );
  }
}

enum CartSummaryType {
  none, // no summary
  compact, // only total price
  full, // total price and total items
}
