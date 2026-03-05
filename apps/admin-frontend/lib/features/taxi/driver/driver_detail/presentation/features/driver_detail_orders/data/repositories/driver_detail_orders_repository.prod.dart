import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/components/charts/chart_series_data.dart';
import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_orders/data/repositories/driver_detail_orders_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: DriverDetailOrdersRepository)
class DriverDetailOrdersRepositoryImpl implements DriverDetailOrdersRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverDetailOrdersRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<List<ChartSeriesData<Enum$UserActivityLevel>>>>
  getEarningsOverTimeStatistics({
    required Input$ChartFilterInput filter,
  }) async {
    // TODO: implement getEarningsOverTimeStatistics
    return ApiResponse.loaded([]);
  }

  @override
  Future<ApiResponse<List<Fragment$RevenuePerApp>>>
  getRideAcceptanceStatistics({required Input$ChartFilterInput filter}) async {
    // TODO: implement getRideAcceptanceStatistics
    return ApiResponse.loaded([]);
  }

  @override
  Future<ApiResponse<List<Fragment$GenderDistribution>>>
  getRideCompletionStatistics() async {
    // TODO: implement getRideCompletionStatistics
    return ApiResponse.loaded([]);
  }
}
