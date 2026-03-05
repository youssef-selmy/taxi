import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/shop_overview/data/graphql/shop_overview.graphql.dart';

abstract class ShopOverviewRepository {
  Future<ApiResponse<Query$overviewKPIs>> getKPIs({required String currency});

  Future<ApiResponse<Query$activeOrders>> getActiveOrders({
    required String currency,
  });

  Future<ApiResponse<Query$pendingShops>> getPendingShops();

  Future<ApiResponse<Query$pendingSupportRequests>> getPendingSupportRequets();

  Future<ApiResponse<List<Fragment$leaderboardItem>>> getTopSpendingCustomers();

  Future<ApiResponse<List<Fragment$leaderboardItem>>> getTopEarningShops();
}
