import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/blocs/shop_dispatcher.cubit.dart';
import 'package:admin_frontend/features/shop/shop_dispatcher/presentation/components/cart/cart_item.dart';

class CartList extends StatelessWidget {
  final List<ShopCart> carts;

  const CartList({super.key, required this.carts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: carts.length,
      shrinkWrap: true,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final cart = carts[index];
        return Column(
          children: [
            Row(
              children: [
                if (cart.shop.image != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: CachedNetworkImage(
                      imageUrl: cart.shop.image!.address,
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
                const SizedBox(width: 4),
                Text(cart.shop.name, style: context.textTheme.labelMedium),
              ],
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              itemCount: cart.items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return CartItem(cart: cart, cartItem: item);
              },
            ),
          ],
        );
      },
    );
  }
}
