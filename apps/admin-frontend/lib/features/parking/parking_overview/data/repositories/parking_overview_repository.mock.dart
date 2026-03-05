import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_support_request.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_overview/data/graphql/parking_overview.graphql.dart';
import 'package:admin_frontend/features/parking/parking_overview/data/repositories/parking_overview_repository.dart';

@dev
@LazySingleton(as: ParkingOverviewRepository)
class ParkingOverviewRepositoryMock implements ParkingOverviewRepository {
  @override
  Future<ApiResponse<Query$activeOrders>> getActiveOrders({
    required String currency,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$activeOrders(
        activeOrders: Query$activeOrders$activeOrders(
          nodes: mockParkingOrderListItems,
          pageInfo: mockPageInfo,
          totalCount: mockParkingOrderListItems.length,
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
        totalParkings: Query$overviewKPIs$totalParkings(totalCount: 59123),
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
  Future<ApiResponse<Query$pendingParkings>> getPendingParkings() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$pendingParkings(
        parkSpots: Query$pendingParkings$parkSpots(
          nodes: mockParkingListItems,
          pageInfo: mockPageInfo,
          totalCount: mockParkingListItems.length,
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
        parkingSupportRequests:
            Query$pendingSupportRequests$parkingSupportRequests(
              nodes: mockParkingSupportRequests,
              pageInfo: mockPageInfo,
              totalCount: mockParkingSupportRequests.length,
            ),
      ),
    );
  }

  @override
  Future<ApiResponse<List<Fragment$leaderboardItem>>> getTopEarningParkings({
    required String currency,
  }) async {
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
