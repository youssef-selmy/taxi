import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_item.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_items_and_categories.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopDetailItemsRepository {
  Future<ApiResponse<Query$shopItems>> getShopItems({
    required Input$ItemFilter filter,
    required List<Input$ItemSort> sorting,
    required Input$OffsetPaging? paging,
  });

  Future<ApiResponse<Fragment$shopItemListItem>> getShopItem({
    required String itemId,
  });

  Future<ApiResponse<void>> deleteShopItem({required String itemId});
}
