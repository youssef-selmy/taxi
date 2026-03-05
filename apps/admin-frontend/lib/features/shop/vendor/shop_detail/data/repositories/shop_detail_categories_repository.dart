import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_item_category.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_items_and_categories.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopDetailCategoriesRepository {
  Future<ApiResponse<Query$shopItemCategories>> getShopItemCategories({
    required Input$ItemCategoryFilter filter,
    required List<Input$ItemCategorySort> sorting,
    required Input$OffsetPaging? paging,
  });

  Future<ApiResponse<Fragment$shopItemCategoryDetail>> getShopItemCategory({
    required String id,
  });

  Future<ApiResponse<void>> deleteShopItemCategory({required String id});

  Future<ApiResponse<void>> createShopItemCategory({
    required Input$CreateItemCategoryInput input,
  });

  Future<ApiResponse<void>> updateShopItemCategory({
    required String id,
    required Input$UpdateItemCategoryInput input,
  });
}
