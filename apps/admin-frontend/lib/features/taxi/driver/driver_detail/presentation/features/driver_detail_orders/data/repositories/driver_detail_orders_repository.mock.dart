import 'dart:math';

import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_orders/data/repositories/driver_detail_orders_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: DriverDetailOrdersRepository)
class DriverDetailOrdersRepositoryMock implements DriverDetailOrdersRepository {
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
  Future<ApiResponse<List<Fragment$GenderDistribution>>>
  getRideCompletionStatistics() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded([
      Fragment$GenderDistribution(count: 2561, gender: Enum$Gender.Female),
      Fragment$GenderDistribution(count: 3814, gender: Enum$Gender.Male),
    ]);
  }
}
