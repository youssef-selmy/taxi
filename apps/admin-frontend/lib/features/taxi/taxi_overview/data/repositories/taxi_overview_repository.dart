import 'package:admin_frontend/core/graphql/fragments/driver_location.fragment.graphql.dart';
import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/data/graphql/taxi_overview.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class TaxiOverviewRepository {
  Stream<ApiResponse<List<Fragment$LocationCluster>>> get onlineDriversClusters;
  Stream<ApiResponse<List<Fragment$LocationWithId>>> get singleOnlineDrivers;

  void startSubscribingToDriverClusters({
    required List<String> h3Indexes,
    required int h3Resolution,
  });

  void stopSubscribingToDriverClusters();

  void startSubscribingToDriverLocations({required List<String> driverIds});

  void stopSubscribingToDriverLocations();

  Future<ApiResponse<Query$overviewKPIs>> getKPIs({required String currency});

  Future<ApiResponse<Query$onlineDrivers>> getOnlineDrivers({
    required Input$BoundsInput bounds,
  });

  Future<ApiResponse<Query$pendingDrivers>> getPendingDrivers();

  Future<ApiResponse<Query$pendingSupportRequests>> getPendingSupportRequets();

  Future<ApiResponse<List<Fragment$leaderboardItem>>> getTopSpendingCustomers();

  Future<ApiResponse<List<Fragment$leaderboardItem>>> getTopEarningDrivers({
    required String currency,
  });
}
