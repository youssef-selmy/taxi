import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/features/shop/shop_management/shop_categories/shop_category_list/data/graphql/shop_category_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_management/shop_categories/shop_category_list/data/repositories/shop_category_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopCategoryListRepository)
class ShopCategoryListRepositoryMock implements ShopCategoryListRepository {
  @override
  Future<ApiResponse<Query$shopCategories>> getShopCategories({
    required Input$OffsetPaging? paging,
    required List<Input$ShopCategorySort> sorting,
    required Input$ShopCategoryFilter filter,
  }) async {
    return ApiResponse.loaded(
      Query$shopCategories(
        shopCategories: Query$shopCategories$shopCategories(
          nodes: [],
          pageInfo: mockPageInfo,
          totalCount: 0,
        ),
      ),
    );
    // return ApiResponse.loaded(
    //   Query$shopCategories(
    //     shopCategories: Query$shopCategories$shopCategories(
    //       nodes: mockShopCategories,
    //       pageInfo: mockPageInfo,
    //       totalCount: mockShopCategories.length,
    //     ),
    //   ),
    // );
  }
}
