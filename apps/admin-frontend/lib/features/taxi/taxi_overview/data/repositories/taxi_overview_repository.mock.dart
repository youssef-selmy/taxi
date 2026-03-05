import 'package:admin_frontend/core/graphql/fragments/driver_location.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_location.mock.dart';
import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/driver.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_support_request.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/data/graphql/taxi_overview.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/data/repositories/taxi_overview_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:rxdart/rxdart.dart';

@dev
@LazySingleton(as: TaxiOverviewRepository)
class TaxiOverviewRepositoryMock implements TaxiOverviewRepository {
  final BehaviorSubject<ApiResponse<List<Fragment$LocationCluster>>>
  _onlineDriversClustersController =
      BehaviorSubject<ApiResponse<List<Fragment$LocationCluster>>>();

  @override
  Stream<ApiResponse<List<Fragment$LocationCluster>>>
  get onlineDriversClusters => _onlineDriversClustersController.stream;

  final BehaviorSubject<ApiResponse<List<Fragment$LocationWithId>>>
  _singleOnlineDriversController =
      BehaviorSubject<ApiResponse<List<Fragment$LocationWithId>>>();

  @override
  Stream<ApiResponse<List<Fragment$LocationWithId>>> get singleOnlineDrivers =>
      _singleOnlineDriversController.stream;

  @override
  void startSubscribingToDriverClusters({
    required List<String> h3Indexes,
    required int h3Resolution,
  }) {
    _onlineDriversClustersController.add(ApiResponse.loading());
  }

  @override
  void stopSubscribingToDriverClusters() {
    _onlineDriversClustersController.add(ApiResponse.loaded([]));
  }

  @override
  Future<ApiResponse<Query$overviewKPIs>> getKPIs({
    required String currency,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$overviewKPIs(
        totalCustomers: Query$overviewKPIs$totalCustomers(totalCount: 95622),
        totalDrivers: Query$overviewKPIs$totalDrivers(totalCount: 59123),
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
  Future<ApiResponse<Query$onlineDrivers>> getOnlineDrivers({
    required Input$BoundsInput bounds,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$onlineDrivers(
        driverLocationsByViewport:
            Query$onlineDrivers$driverLocationsByViewport(
              clusters: [],
              singles: [],
              h3IndexesInView: [],
              totalCount: 0,
              h3Resolution: 4,
            ),
        getDriversLocationWithData: mockDriverLocations,
      ),
    );
  }

  @override
  Future<ApiResponse<Query$pendingDrivers>> getPendingDrivers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$pendingDrivers(
        drivers: Query$pendingDrivers$drivers(
          nodes: mockDriverListItems,
          pageInfo: mockPageInfo,
          totalCount: mockDriverListItems.length,
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
        taxiSupportRequests: Query$pendingSupportRequests$taxiSupportRequests(
          nodes: mockTaxiSupportRequests,
          pageInfo: mockPageInfo,
          totalCount: mockTaxiSupportRequests.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<List<Fragment$leaderboardItem>>> getTopEarningDrivers({
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

  @override
  void startSubscribingToDriverLocations({required List<String> driverIds}) {
    _singleOnlineDriversController.add(ApiResponse.loaded([]));
  }

  @override
  void stopSubscribingToDriverLocations() {
    _singleOnlineDriversController.add(ApiResponse.loaded([]));
  }
}
