import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.mock.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_orders.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_orders_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopDetailOrdersRepository)
class ShopDetailOrdersRepositoryMock implements ShopDetailOrdersRepository {
  @override
  Future<ApiResponse<Query$shopActiveOrders>> getShopActiveOrders({
    required String shopId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopActiveOrders(
        shopOrders: Query$shopActiveOrders$shopOrders(
          nodes: mockShopOrderListItems,
          pageInfo: mockPageInfo,
          totalCount: mockShopOrderListItems.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$shopOrders>> getShopOrders({
    required Input$ShopOrderFilter filter,
    required Input$OffsetPaging? paging,
    required List<Input$ShopOrderSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopOrders(
        shopOrders: Query$shopOrders$shopOrders(
          nodes: mockShopOrderListItems,
          pageInfo: mockPageInfo,
          totalCount: mockShopOrderListItems.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$orderShopDetail>> getOrderDetail({
    required String orderId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockOrderShopDetail);
  }
}
