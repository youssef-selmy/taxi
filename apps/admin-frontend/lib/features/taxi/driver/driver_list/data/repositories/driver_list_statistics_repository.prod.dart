import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/data/graphql/driver_insights.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/data/repositories/driver_list_statistics_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: DriverListStatisticsRepository)
class DriverListStatisticsRepositoryImpl
    implements DriverListStatisticsRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverListStatisticsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$driverStatistics>> getDriverStatistics({
    required String currency,
  }) async {
    final getDriverStatisticsOrError = await graphQLDatasource.query(
      Options$Query$driverStatistics(
        variables: Variables$Query$driverStatistics(currency: currency),
      ),
    );
    return getDriverStatisticsOrError;
  }

  @override
  Future<ApiResponse<List<Fragment$RevenuePerApp>>>
  getRideAcceptanceStatistics({required Input$ChartFilterInput filter}) async {
    // TODO: implement getRideAcceptanceStatistics
    return ApiResponse.loaded([]);
  }

  @override
  Future<ApiResponse<List<Fragment$RevenuePerApp>>>
  getTripsCompletedStatistics({required Input$ChartFilterInput filter}) async {
    // TODO: implement getTripsCompletedStatistics
    return ApiResponse.loaded([]);
  }

  @override
  Future<ApiResponse<List<Fragment$ActiveInactiveUsers>>>
  getActiveInActiveStatistics() async {
    final activeInactiveUsersOrError = await graphQLDatasource.query(
      Options$Query$activeInactiveDrivers(),
    );
    return activeInactiveUsersOrError.mapData(
      (item) => item.activeInactiveDrivers,
    );
  }

  @override
  Future<ApiResponse<List<Fragment$leaderboardItem>>> getTopEarningDrivers({
    required String currency,
  }) async {
    final getTopEarningDriversOrError = await graphQLDatasource.query(
      Options$Query$topEarningDrivers(
        variables: Variables$Query$topEarningDrivers(currency: currency),
      ),
    );
    return getTopEarningDriversOrError.mapData(
      (item) => item.topEarningDrivers,
    );
  }

  @override
  Future<ApiResponse<List<ChartSeriesData<Enum$UserActivityLevel>>>>
  getEarningsDistributionStatistics({
    required Input$ChartFilterInput filter,
  }) async {
    // TODO: implement getEarningsDistributionStatistics
    return ApiResponse.loaded([]);
  }

  @override
  Future<ApiResponse<List<ChartSeriesData<Enum$UserActivityLevel>>>>
  getEarningsOverTimeStatistics({
    required Input$ChartFilterInput filter,
  }) async {
    // TODO: implement getEarningsOverTimeStatistics
    return ApiResponse.loaded([]);
  }

  @override
  Future<ApiResponse<List<Fragment$leaderboardItem>>>
  getTopRideAcceptanceDrivers() async {
    final getTopRideAcceptanceDriversOrError = await graphQLDatasource.query(
      Options$Query$topTripsCompletedDrivers(),
    );
    return getTopRideAcceptanceDriversOrError.mapData(
      (item) => item.topTripsCompletedDrivers,
    );
  }

  @override
  Future<ApiResponse<Query$rideCountByStatus>> getRideCompletionStatistics() {
    final rideCompletionStatisticsOrError = graphQLDatasource.query(
      Options$Query$rideCountByStatus(),
    );
    return rideCompletionStatisticsOrError;
  }
}
