import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/shop/shop_order/shop_order_list/data/graphql/shop_order_list.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopOrderListRepository {
  Future<ApiResponse<Query$shopOrders>> getShopOrders({
    required Input$OffsetPaging? paging,
    required Input$ShopOrderFilter filter,
    required List<Input$ShopOrderSort> sorting,
  });

  Future<ApiResponse<Query$getShopOrdersOverview>> getShopOrderStatistics();

  Future<ApiResponse<Query$shopCategories>> getShopCategories();
}
