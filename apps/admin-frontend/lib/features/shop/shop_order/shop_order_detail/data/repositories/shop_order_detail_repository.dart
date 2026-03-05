import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ShopOrderDetailRepository {
  Future<ApiResponse<Fragment$orderShopDetail>> getShopOrderDetail({
    required String id,
  });

  Future<ApiResponse<Fragment$orderShopDetail>> shopOrderDetailCancelOrder({
    required Input$CancelShopOrderCartsInput input,
  });

  Future<ApiResponse<Fragment$orderShopDetail>> shopOrderDetailRemoveItem({
    required Input$RemoveItemFromCartInput input,
  });
}
