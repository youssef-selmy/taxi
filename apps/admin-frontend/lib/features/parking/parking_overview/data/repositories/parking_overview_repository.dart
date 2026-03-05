import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';
import 'package:admin_frontend/features/parking/parking_overview/data/graphql/parking_overview.graphql.dart';

abstract class ParkingOverviewRepository {
  Future<ApiResponse<Query$overviewKPIs>> getKPIs({required String currency});

  Future<ApiResponse<Query$activeOrders>> getActiveOrders({
    required String currency,
  });

  Future<ApiResponse<Query$pendingParkings>> getPendingParkings();

  Future<ApiResponse<Query$pendingSupportRequests>> getPendingSupportRequets();

  Future<ApiResponse<List<Fragment$leaderboardItem>>> getTopSpendingCustomers();

  Future<ApiResponse<List<Fragment$leaderboardItem>>> getTopEarningParkings({
    required String currency,
  });
}
