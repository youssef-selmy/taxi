import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_items_and_categories.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_items_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopDetailItemsRepository)
class ShopDetailItemsRepositoryMock implements ShopDetailItemsRepository {
  @override
  Future<ApiResponse<Query$shopItems>> getShopItems({
    required Input$ItemFilter filter,
    required List<Input$ItemSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopItems(
        items: Query$shopItems$items(
          nodes: mockShopItemListItems,
          pageInfo: mockPageInfo,
          totalCount: mockShopItemListItems.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<void>> deleteShopItem({required String itemId}) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<Fragment$shopItemListItem>> getShopItem({
    required String itemId,
  }) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ApiResponse.loaded(mockShopItemListItem1);
  }
}
