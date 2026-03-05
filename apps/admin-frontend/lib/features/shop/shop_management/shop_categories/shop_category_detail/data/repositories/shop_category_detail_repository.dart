import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopCategoryDetailRepository {
  Future<ApiResponse<Fragment$shopCategory>> getShopCategory(String id);

  Future<ApiResponse<Fragment$shopCategory>> createShopCategory({
    required Input$CreateShopCategoryInput input,
  });

  Future<ApiResponse<Fragment$shopCategory>> updateShopCategory({
    required String id,
    required Input$UpdateShopCategoryInput input,
  });

  Future<ApiResponse<void>> deleteShopCategory(String id);
}
