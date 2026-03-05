import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/shop.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.mock.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_create/data/repositories/vendor_create_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: VendorCreateRepository)
class VendorCreateRepositoryMock implements VendorCreateRepository {
  @override
  Future<ApiResponse<Fragment$shopDetail>> createShop({
    required Input$UpsertShopInput input,
    required List<String> categoryIds,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockShopDetail);
  }

  @override
  Future<ApiResponse<Fragment$shopDetail>> getShopDetail({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockShopDetail);
  }

  @override
  Future<ApiResponse<Fragment$shopDetail>> updateShop({
    required String id,
    required Input$UpsertShopInput input,
    required List<String> categoryIds,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockShopDetail);
  }

  @override
  Future<ApiResponse<List<Fragment$shopCategoryCompact>>>
  getShopCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockShopCategoriesCompact);
  }
}
