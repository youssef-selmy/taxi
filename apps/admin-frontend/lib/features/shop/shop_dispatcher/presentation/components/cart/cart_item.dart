import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/shop_dispatcher.cubit.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/plus_minus_cart.dart';

class CartItem extends StatelessWidget {
  final ShopCart cart;
  final ShopCartItem cartItem;

  const CartItem({super.key, required this.cartItem, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (cartItem.item.image != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: cartItem.item.image!.address,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ],
            const SizedBox(width: 8),
            Text(cartItem.item.name, style: context.textTheme.labelMedium),
          ],
        ),
        const SizedBox(height: 8),
        ...cartItem.itemOptions.map(
          (option) => Row(
            children: [
              Text(
                option.name,
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colors.onSurface,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                option.price.formatCurrency(cart.shop.currency),
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            BlocBuilder<ShopDispatcherBloc, ShopDispatcherState>(
              builder: (context, state) {
                return PlusMinusCart(
                  quantity: cartItem.quantity,
                  onChanged: (value) {
                    context.read<ShopDispatcherBloc>().changeQuantity(
                      cart: cart,
                      item: cartItem,
                      quantity: value,
                    );
                  },
                );
              },
            ),
            const Spacer(),
            Text(
              cartItem.total.formatCurrency(cart.shop.currency),
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
