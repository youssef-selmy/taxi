import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/shop.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class VendorCreateRepository {
  Future<ApiResponse<Fragment$shopDetail>> createShop({
    required Input$UpsertShopInput input,
    required List<String> categoryIds,
  });

  Future<ApiResponse<Fragment$shopDetail>> updateShop({
    required String id,
    required Input$UpsertShopInput input,
    required List<String> categoryIds,
  });

  Future<ApiResponse<Fragment$shopDetail>> getShopDetail({required String id});

  Future<ApiResponse<List<Fragment$shopCategoryCompact>>> getShopCategories();
}
