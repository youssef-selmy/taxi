import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_list/data/graphql/shop_order_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_list/data/repositories/shop_order_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ShopOrderListRepository)
class ShopOrderListRepositoryMock implements ShopOrderListRepository {
  @override
  Future<ApiResponse<Query$shopOrders>> getShopOrders({
    required Input$OffsetPaging? paging,
    required Input$ShopOrderFilter filter,
    required List<Input$ShopOrderSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopOrders(
        shopOrders: Query$shopOrders$shopOrders(
          totalCount: mockShopOrderListItems.length,
          pageInfo: mockPageInfo,
          nodes: mockShopOrderListItems,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$getShopOrdersOverview>>
  getShopOrderStatistics() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$getShopOrdersOverview(
        shopOrderAggregate: [
          Query$getShopOrdersOverview$shopOrderAggregate(
            avg: Query$getShopOrdersOverview$shopOrderAggregate$avg(total: 43),
          ),
        ],
        thisWeekOrders: [
          Query$getShopOrdersOverview$thisWeekOrders(
            count: Query$getShopOrdersOverview$thisWeekOrders$count(id: 100),
          ),
        ],
        groupByStatus: [
          Query$getShopOrdersOverview$groupByStatus(
            count: Query$getShopOrdersOverview$groupByStatus$count(id: 100),
            groupBy: Query$getShopOrdersOverview$groupByStatus$groupBy(
              status: Enum$ShopOrderStatus.OnHold,
            ),
          ),
          Query$getShopOrdersOverview$groupByStatus(
            count: Query$getShopOrdersOverview$groupByStatus$count(id: 51),
            groupBy: Query$getShopOrdersOverview$groupByStatus$groupBy(
              status: Enum$ShopOrderStatus.Processing,
            ),
          ),
          Query$getShopOrdersOverview$groupByStatus(
            count: Query$getShopOrdersOverview$groupByStatus$count(id: 32),
            groupBy: Query$getShopOrdersOverview$groupByStatus$groupBy(
              status: Enum$ShopOrderStatus.Completed,
            ),
          ),
          Query$getShopOrdersOverview$groupByStatus(
            count: Query$getShopOrdersOverview$groupByStatus$count(id: 535),
            groupBy: Query$getShopOrdersOverview$groupByStatus$groupBy(
              status: Enum$ShopOrderStatus.PaymentPending,
            ),
          ),
        ],
        totalOrders: [
          Query$getShopOrdersOverview$totalOrders(
            count: Query$getShopOrdersOverview$totalOrders$count(total: 718),
          ),
        ],
        lastWeekOrder: [
          Query$getShopOrdersOverview$lastWeekOrder(
            count: Query$getShopOrdersOverview$lastWeekOrder$count(id: 31),
          ),
        ],
      ),
    );
  }

  @override
  Future<ApiResponse<Query$shopCategories>> getShopCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$shopCategories(
        shopCategories: Query$shopCategories$shopCategories(
          nodes: mockShopCategories,
        ),
      ),
    );
  }
}
