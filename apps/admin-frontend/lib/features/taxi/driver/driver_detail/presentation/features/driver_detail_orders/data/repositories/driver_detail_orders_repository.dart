import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class DriverDetailOrdersRepository {
  Future<ApiResponse<List<Fragment$GenderDistribution>>>
  getRideCompletionStatistics();

  Future<ApiResponse<List<Fragment$RevenuePerApp>>>
  getRideAcceptanceStatistics({required Input$ChartFilterInput filter});

  Future<ApiResponse<List<ChartSeriesData<Enum$UserActivityLevel>>>>
  getEarningsOverTimeStatistics({required Input$ChartFilterInput filter});
}
