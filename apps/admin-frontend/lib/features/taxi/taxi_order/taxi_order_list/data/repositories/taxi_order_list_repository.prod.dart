import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/data/graphql/taxi_order_list.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_list/data/repositories/taxi_order_list_repository.dart';

@prod
@LazySingleton(as: TaxiOrderListRepository)
class TaxiOrderListRepositoryImpl implements TaxiOrderListRepository {
  final GraphqlDatasource graphQLDatasource;

  TaxiOrderListRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$fleets>> getFleets() async {
    final fleetsOrError = await graphQLDatasource.query(Options$Query$fleets());
    return fleetsOrError;
  }

  @override
  Future<ApiResponse<Query$getOrdersOverview>> getTaxiOrderStatistics() {
    final lastWeekStartDate = DateTime.now().startOfPreviousWeek;
    final lastWeekEndDate = DateTime.now().endOfPreviousWeek;
    final thisWeekStartDate = DateTime.now().startOfThisWeek;
    final thisWeekEndDate = DateTime.now().endOfThisWeek;
    final overviewOrError = graphQLDatasource.query(
      Options$Query$getOrdersOverview(
        variables: Variables$Query$getOrdersOverview(
          lastWeekStartDate: lastWeekStartDate,
          lastWeekEndDate: lastWeekEndDate,
          thisWeekStartDate: thisWeekStartDate,
          thisWeekEndDate: thisWeekEndDate,
        ),
      ),
    );
    return overviewOrError;
  }
}
