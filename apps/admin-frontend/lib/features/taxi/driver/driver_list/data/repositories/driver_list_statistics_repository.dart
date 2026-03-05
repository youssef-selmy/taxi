import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/data/graphql/driver_insights.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class DriverListStatisticsRepository {
  Future<ApiResponse<Query$driverStatistics>> getDriverStatistics({
    required String currency,
  });

  Future<ApiResponse<List<Fragment$RevenuePerApp>>>
  getTripsCompletedStatistics({required Input$ChartFilterInput filter});

  Future<ApiResponse<List<Fragment$RevenuePerApp>>>
  getRideAcceptanceStatistics({required Input$ChartFilterInput filter});

  Future<ApiResponse<List<Fragment$ActiveInactiveUsers>>>
  getActiveInActiveStatistics();

  Future<ApiResponse<Query$rideCountByStatus>> getRideCompletionStatistics();

  Future<ApiResponse<List<Fragment$leaderboardItem>>>
  getTopRideAcceptanceDrivers();

  Future<ApiResponse<List<Fragment$leaderboardItem>>> getTopEarningDrivers({
    required String currency,
  });

  Future<ApiResponse<List<ChartSeriesData<Enum$UserActivityLevel>>>>
  getEarningsDistributionStatistics({required Input$ChartFilterInput filter});

  Future<ApiResponse<List<ChartSeriesData<Enum$UserActivityLevel>>>>
  getEarningsOverTimeStatistics({required Input$ChartFilterInput filter});
}
