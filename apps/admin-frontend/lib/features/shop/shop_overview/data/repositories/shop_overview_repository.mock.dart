import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_order.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_support_request.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/shop/shop_overview/data/graphql/shop_overview.graphql.dart';
import 'package:admin_frontend/features/shop/shop_overview/data/repositories/shop_overview_repository.dart';

@dev
@LazySingleton(as: ShopOverviewRepository)
class ShopOverviewRepositoryMock implements ShopOverviewRepository {
  @override
  Future<ApiResponse<Query$activeOrders>> getActiveOrders({
    required String currency,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$activeOrders(
        activeOrders: Query$activeOrders$activeOrders(
          nodes: mockShopOrderListItems,
          pageInfo: mockPageInfo,
          totalCount: mockShopOrderListItems.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$overviewKPIs>> getKPIs({
    required String currency,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$overviewKPIs(
        totalCustomers: Query$overviewKPIs$totalCustomers(totalCount: 95622),
        totalShops: Query$overviewKPIs$totalShops(totalCount: 59123),
        totalOrders: Query$overviewKPIs$totalOrders(totalCount: 4432901),
        totalRevenue: [
          Query$overviewKPIs$totalRevenue(
            sum: Query$overviewKPIs$totalRevenue$sum(amount: 123456789),
          ),
        ],
      ),
    );
  }

  @override
  Future<ApiResponse<Query$pendingShops>> getPendingShops() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$pendingShops(
        shops: Query$pendingShops$shops(
          nodes: mockShopListItems,
          pageInfo: mockPageInfo,
          totalCount: mockShopListItems.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$pendingSupportRequests>>
  getPendingSupportRequets() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$pendingSupportRequests(
        shopSupportRequests: Query$pendingSupportRequests$shopSupportRequests(
          nodes: mockShopSupportRequests,
          pageInfo: mockPageInfo,
          totalCount: mockShopSupportRequests.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<List<Fragment$leaderboardItem>>>
  getTopEarningShops() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockLeaderboardItems);
  }

  @override
  Future<ApiResponse<List<Fragment$leaderboardItem>>>
  getTopSpendingCustomers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockLeaderboardItems);
  }
}
