import 'package:image_faker/image_faker.dart';

import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

final mockShopCategory1 = Fragment$shopCategory(
  id: "1",
  name: "Restaurant",
  image: ImageFaker().shop.category.restaurant.toMedia,
  status: Enum$ShopCategoryStatus.Enabled,
  shops: Fragment$shopCategory$shops(totalCount: 25),
);

final mockShopCategory2 = Fragment$shopCategory(
  id: "2",
  name: "Grocery",
  image: ImageFaker().shop.category.grocery.toMedia,
  status: Enum$ShopCategoryStatus.Enabled,
  shops: Fragment$shopCategory$shops(totalCount: 10),
);

final mockShopCategory3 = Fragment$shopCategory(
  id: "3",
  name: "Bakery",
  image: ImageFaker().shop.category.bakery.toMedia,
  status: Enum$ShopCategoryStatus.Enabled,
  shops: Fragment$shopCategory$shops(totalCount: 14),
);

final mockShopCategory4 = Fragment$shopCategory(
  id: "4",
  name: "Cafe",
  image: ImageFaker().shop.category.coffeeShop.toMedia,
  status: Enum$ShopCategoryStatus.Enabled,
  shops: Fragment$shopCategory$shops(totalCount: 7),
);

final mockShopCategory5 = Fragment$shopCategory(
  id: "5",
  name: "Pet Shop",
  image: ImageFaker().shop.category.petShop.toMedia,
  status: Enum$ShopCategoryStatus.Enabled,
  shops: Fragment$shopCategory$shops(totalCount: 15),
);

final mockShopCategories = [
  mockShopCategory1,
  mockShopCategory2,
  mockShopCategory3,
  mockShopCategory4,
  mockShopCategory5,
];

final mockShopCategoryCompact1 = Fragment$shopCategoryCompact(
  id: "1",
  name: "Restaurant",
);

final mockShopCategoryCompact2 = Fragment$shopCategoryCompact(
  id: "2",
  name: "Grocery",
);

final mockShopCategoryCompact3 = Fragment$shopCategoryCompact(
  id: "3",
  name: "Pastry",
);

final mockShopCategoryCompact4 = Fragment$shopCategoryCompact(
  id: "4",
  name: "Cafe",
);

final mockShopCategoryCompact5 = Fragment$shopCategoryCompact(
  id: "5",
  name: "Pet Shop",
);

final mockShopCategoriesCompact = [
  mockShopCategoryCompact1,
  mockShopCategoryCompact2,
  mockShopCategoryCompact3,
  mockShopCategoryCompact4,
  mockShopCategoryCompact5,
];
