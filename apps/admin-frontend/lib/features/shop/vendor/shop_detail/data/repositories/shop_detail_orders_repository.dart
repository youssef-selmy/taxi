import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_orders.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopDetailOrdersRepository {
  Future<ApiResponse<Query$shopOrders>> getShopOrders({
    required Input$ShopOrderFilter filter,
    required Input$OffsetPaging? paging,
    required List<Input$ShopOrderSort> sorting,
  });

  Future<ApiResponse<Query$shopActiveOrders>> getShopActiveOrders({
    required String shopId,
  });

  Future<ApiResponse<Fragment$orderShopDetail>> getOrderDetail({
    required String orderId,
  });
}
