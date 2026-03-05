import 'package:admin_frontend/core/graphql/fragments/shop_item_category.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item_preset.fragment.graphql.mock.dart';

final mockShopItemCategory1 = Fragment$shopItemCategoryListItem(
  id: "1",
  name: "Dishes",
  products: Fragment$shopItemCategoryListItem$products(totalCount: 40),
);

final mockShopItemCategory2 = Fragment$shopItemCategoryListItem(
  id: "2",
  name: "Pizza",
  products: Fragment$shopItemCategoryListItem$products(totalCount: 30),
);

final mockShopItemCategory3 = Fragment$shopItemCategoryListItem(
  id: "3",
  name: "Burgers",
  products: Fragment$shopItemCategoryListItem$products(totalCount: 70),
);

final mockShopItemCategories = [
  mockShopItemCategory1,
  mockShopItemCategory2,
  mockShopItemCategory3,
];

final mockShopItemCategoryDetail = Fragment$shopItemCategoryDetail(
  id: "1",
  name: "Dishes",
  presets: [mockShopItemPreset1],
);
