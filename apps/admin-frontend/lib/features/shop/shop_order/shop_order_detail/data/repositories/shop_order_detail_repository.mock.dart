import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/data/repositories/shop_order_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopOrderDetailRepository)
class ShopOrderDetailRepositoryMock implements ShopOrderDetailRepository {
  @override
  Future<ApiResponse<Fragment$orderShopDetail>> getShopOrderDetail({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockOrderShopDetail);
  }

  @override
  Future<ApiResponse<Fragment$orderShopDetail>> shopOrderDetailCancelOrder({
    required Input$CancelShopOrderCartsInput input,
  }) async {
    return ApiResponse.loaded(mockOrderShopDetail);
  }

  @override
  Future<ApiResponse<Fragment$orderShopDetail>> shopOrderDetailRemoveItem({
    required Input$RemoveItemFromCartInput input,
  }) async {
    return ApiResponse.loaded(mockOrderShopDetail);
  }
}
