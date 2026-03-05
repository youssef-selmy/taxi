import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item_category.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item_category.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_items_and_categories.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_categories_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopDetailCategoriesRepository)
class ShopDetailCategoriesRepositoryMock
    implements ShopDetailCategoriesRepository {
  @override
  Future<ApiResponse<Query$shopItemCategories>> getShopItemCategories({
    required Input$ItemCategoryFilter filter,
    required List<Input$ItemCategorySort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopItemCategories(
        itemCategories: Query$shopItemCategories$itemCategories(
          nodes: mockShopItemCategories,
          pageInfo: mockPageInfo,
          totalCount: mockShopItemCategories.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<void>> deleteShopItemCategory({required String id}) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<Fragment$shopItemCategoryDetail>> getShopItemCategory({
    required String id,
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(mockShopItemCategoryDetail);
  }

  @override
  Future<ApiResponse<void>> createShopItemCategory({
    required Input$CreateItemCategoryInput input,
  }) async {
    return ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<void>> updateShopItemCategory({
    required String id,
    required Input$UpdateItemCategoryInput input,
  }) async {
    return ApiResponse.loaded(null);
  }
}
