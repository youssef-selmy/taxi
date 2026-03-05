import 'dart:math';

import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.mock.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/data/graphql/driver_insights.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/data/repositories/driver_list_statistics_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: DriverListStatisticsRepository)
class DriverListStatisticsRepositoryMock
    implements DriverListStatisticsRepository {
  @override
  Future<ApiResponse<Query$driverStatistics>> getDriverStatistics({
    required String currency,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$driverStatistics(
        activeDrivers: Query$driverStatistics$activeDrivers(totalCount: 120),
        totalEarnings: [
          Query$driverStatistics$totalEarnings(
            sum: Query$driverStatistics$totalEarnings$sum(balance: 230),
          ),
          Query$driverStatistics$totalEarnings(
            sum: Query$driverStatistics$totalEarnings$sum(balance: 115),
          ),
          Query$driverStatistics$totalEarnings(
            sum: Query$driverStatistics$totalEarnings$sum(balance: 440),
          ),
        ],
        totalTripsCompleted: Query$driverStatistics$totalTripsCompleted(
          totalCount: 84,
        ),
        averageRatings: [
          Query$driverStatistics$averageRatings(
            avg: Query$driverStatistics$averageRatings$avg(rating: 89),
          ),
        ],
      ),
    );
  }

  @override
  Future<ApiResponse<List<Fragment$RevenuePerApp>>>
  getRideAcceptanceStatistics({required Input$ChartFilterInput filter}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded([
      for (var app in Enum$AppType.values.where(
        (app) => app != Enum$AppType.$unknown,
      ))
        for (var i = 1; i <= 12; i++)
          Fragment$RevenuePerApp(
            app: app,
            date: DateTime(2024, i, 1),
            revenue: (Random().nextInt(10) * 1000) + 20000,
          ),
    ]);
  }

  @override
  Future<ApiResponse<List<Fragment$RevenuePerApp>>>
  getTripsCompletedStatistics({required Input$ChartFilterInput filter}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded([
      for (var app in Enum$AppType.values.where(
        (app) => app != Enum$AppType.$unknown,
      ))
        for (var i = 1; i <= 12; i++)
          Fragment$RevenuePerApp(
            app: app,
            date: DateTime(2024, i, 1),
            revenue: (Random().nextInt(10) * 1000) + 20000,
          ),
    ]);
  }

  @override
  Future<ApiResponse<List<Fragment$ActiveInactiveUsers>>>
  getActiveInActiveStatistics() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockActiveInactiveUsers);
  }

  @override
  Future<ApiResponse<Query$rideCountByStatus>>
  getRideCompletionStatistics() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$rideCountByStatus(
        orderAggregate: [
          Query$rideCountByStatus$orderAggregate(
            groupBy: Query$rideCountByStatus$orderAggregate$groupBy(
              status: Enum$OrderStatus.Finished,
            ),
            count: Query$rideCountByStatus$orderAggregate$count(id: 100),
          ),
          Query$rideCountByStatus$orderAggregate(
            groupBy: Query$rideCountByStatus$orderAggregate$groupBy(
              status: Enum$OrderStatus.RiderCanceled,
            ),
            count: Query$rideCountByStatus$orderAggregate$count(id: 42),
          ),
          Query$rideCountByStatus$orderAggregate(
            groupBy: Query$rideCountByStatus$orderAggregate$groupBy(
              status: Enum$OrderStatus.DriverCanceled,
            ),
            count: Query$rideCountByStatus$orderAggregate$count(id: 64),
          ),
        ],
      ),
    );
  }

  @override
  Future<ApiResponse<List<ChartSeriesData<Enum$UserActivityLevel>>>>
  getEarningsDistributionStatistics({
    required Input$ChartFilterInput filter,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded([
      ChartSeriesData(name: 'Jan', value: 80),
      ChartSeriesData(name: 'Feb', value: 150),
      ChartSeriesData(name: 'Mar', value: 230),
    ]);
  }

  @override
  Future<ApiResponse<List<ChartSeriesData<Enum$UserActivityLevel>>>>
  getEarningsOverTimeStatistics({
    required Input$ChartFilterInput filter,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded([
      ChartSeriesData(name: 'Jan', value: 80),
      ChartSeriesData(name: 'Feb', value: 150),
      ChartSeriesData(name: 'Mar', value: 230),
    ]);
  }

  @override
  Future<ApiResponse<List<Fragment$leaderboardItem>>>
  getTopRideAcceptanceDrivers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockLeaderboardItems);
  }

  @override
  Future<ApiResponse<List<Fragment$leaderboardItem>>> getTopEarningDrivers({
    required String currency,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockLeaderboardItems);
  }
}
