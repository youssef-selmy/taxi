import 'package:image_faker/image_faker.dart';

import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/rating_aggregate.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item_category.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item_preset.fragment.graphql.mock.dart';

final mockShopItemListItem1 = Fragment$shopItemListItem(
  id: '1',
  name: 'Chicken Burger',
  ratingAggregate: mockRatingAggregateHigh,
  image: ImageFaker().food.burgerWithBlueBackground.toMedia,
  basePrice: 7.49,
  variants: mockShopItemVariants,
  options: mockShopItemOptions,
  categories: mockShopItemCategories,
  presets: mockShopItemPresets,
);

final mockShopItemListItem2 = Fragment$shopItemListItem(
  id: '2',
  name: 'Beef Burger',
  ratingAggregate: mockRatingAggregateHigh,
  image: ImageFaker().food.burgerWithBlueBackground.toMedia,
  options: mockShopItemOptions,
  basePrice: 8.49,
  variants: mockShopItemVariants,
  categories: [mockShopItemCategory1, mockShopItemCategory2],
  presets: [mockShopItemPreset1, mockShopItemPreset2],
);

final mockShopItemListItem3 = Fragment$shopItemListItem(
  id: '3',
  name: 'Pork Burger',
  ratingAggregate: mockRatingAggregateHigh,
  image: ImageFaker().food.burgerWithBlueBackground.toMedia,
  variants: mockShopItemVariants,
  options: mockShopItemOptions,
  basePrice: 8.49,
  categories: [mockShopItemCategory3, mockShopItemCategory1],
  presets: [mockShopItemPreset3, mockShopItemPreset1],
);

final mockShopItemListItems = [
  mockShopItemListItem1,
  mockShopItemListItem2,
  mockShopItemListItem3,
];

final mockShopItemVariant1 = Fragment$ItemVariant(
  id: "1",
  name: "Small",
  description: "100g",
  price: 7,
);

final mockShopItemVariant2 = Fragment$ItemVariant(
  id: "2",
  name: "Normal",
  description: "200g",
  price: 10,
);

final mockShopItemVariant3 = Fragment$ItemVariant(
  id: "3",
  name: "Large",
  description: "300g",
  price: 15,
);

final mockShopItemVariants = [
  mockShopItemVariant1,
  mockShopItemVariant2,
  mockShopItemVariant3,
];

final mockShopItemOption1 = Fragment$ItemOption(
  id: "1",
  name: "Extra Cheese",
  price: 2,
);

final mockShopItemOption2 = Fragment$ItemOption(
  id: "2",
  name: "Extra Bacon",
  price: 3,
);

final mockShopItemOption3 = Fragment$ItemOption(
  id: "3",
  name: "Extra Meat",
  price: 4,
);

final mockShopItemOptions = [
  mockShopItemOption1,
  mockShopItemOption2,
  mockShopItemOption3,
];
