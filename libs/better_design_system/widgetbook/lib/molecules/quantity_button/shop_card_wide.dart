import 'package:api_response/api_response.dart';
import 'package:better_design_system/shop_components/shop_cards/shop_card_wide.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppShopCardWide)
Widget defaultShopCardWide(BuildContext context) {
  return AppShopCardWide(
    currency: 'USD',
    onPressed: () {},
    shopResponse: ApiResponse.loaded(
      ShopEntity(
        name: 'MasterChef',
        description: 'A top-notch restaurant with a variety of dishes.',
        rating: 90,
        reviewCount: 100,
        headerImage: ImageFaker().shop.itemBanner.one,
        avatarImage: ImageFaker().shop.logo.masterChef,
        isInactive: false,
        deliveryFee: 5.99,
        deliveryTimeMin: 30,
        deliveryTimeMax: 45,
      ),
    ),
  );
}
