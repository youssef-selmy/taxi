import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/shop/shop_management/shop_categories/shop_category_list/data/graphql/shop_category_list.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopCategoryListRepository {
  Future<ApiResponse<Query$shopCategories>> getShopCategories({
    required Input$OffsetPaging? paging,
    required List<Input$ShopCategorySort> sorting,
    required Input$ShopCategoryFilter filter,
  });
}
