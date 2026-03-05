import 'package:admin_frontend/schema.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:flutter/cupertino.dart';

import 'package:admin_frontend/core/graphql/fragments/shop.graphql.dart';
import 'package:better_design_system/shop_components/shop_cards/shop_card_wide.dart';

class ShopCard extends StatelessWidget {
  final Fragment$DispatcherShop shop;
  final Function(Fragment$DispatcherShop dispatcher)? onTap;

  const ShopCard({super.key, required this.shop, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppShopCardWide(
      currency: shop.currency,
      shopResponse: ApiResponse.loaded(
        ShopEntity(
          name: shop.name,
          avatarImage: shop.image?.address,
          headerImage: shop.headerSmall?.address,
          rating: shop.ratingAggregate?.rating,
          reviewCount: shop.ratingAggregate?.reviewCount,
          deliveryFee: shop.deliveryFee,
          deliveryTimeMin: shop.minDeliveryTime,
          deliveryTimeMax: shop.maxDeliveryTime,
          description: null,
          isInactive: shop.status == Enum$ShopStatus.Inactive,
        ),
      ),
      onPressed: () => onTap!(shop),
    );
  }
}
