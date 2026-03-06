import 'package:api_response/api_response.dart';
import 'package:better_design_system/shop_components/product_cards/food_product_card.dart';
import 'package:flutter/material.dart';
import 'package:image_faker/image_faker.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'Default', type: AppFoodProductCard)
Widget defaultFoodProductCard(BuildContext context) {
  return AppFoodProductCard(
    currency: 'USD',
    onPressed: () {},
    itemResponse: ApiResponse.loaded(
      ProductEntity(
        basePrice: 9.99,
        name: 'Delicious Pizza',
        id: '1',
        description: 'A tasty pizza with fresh ingredients.',
        stockQuantity: 100,
        discountUntil: DateTime.now().add(Duration(days: 7)),
        discountPercentage: 10,
        discountedQuantity: 5,
        usedDiscountedQuantity: 0,
        image: ImageFaker().food.burger,
        shopImage: ImageFaker().shop.logo.masterChef,
        shopName: 'Pizza Place',
        minimumPreparationTime: 50,
        maximumPreparationTime: 75,
        rating: 90,
        reviewCount: 100,
      ),
    ),
  );
}
