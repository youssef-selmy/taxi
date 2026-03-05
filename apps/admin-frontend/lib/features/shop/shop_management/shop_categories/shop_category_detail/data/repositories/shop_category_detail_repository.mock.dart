import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_management/shop_categories/shop_category_detail/data/repositories/shop_category_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopCategoryDetailRepository)
class ShopCategoryDetailRepositoryMock implements ShopCategoryDetailRepository {
  @override
  Future<ApiResponse<Fragment$shopCategory>> createShopCategory({
    required Input$CreateShopCategoryInput input,
  }) async {
    return ApiResponse.loaded(mockShopCategory1);
  }

  @override
  Future<ApiResponse<void>> deleteShopCategory(String id) async {
    return const ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<Fragment$shopCategory>> getShopCategory(String id) async {
    return ApiResponse.loaded(mockShopCategory1);
  }

  @override
  Future<ApiResponse<Fragment$shopCategory>> updateShopCategory({
    required String id,
    required Input$UpdateShopCategoryInput input,
  }) async {
    return ApiResponse.loaded(mockShopCategory1);
  }
}
