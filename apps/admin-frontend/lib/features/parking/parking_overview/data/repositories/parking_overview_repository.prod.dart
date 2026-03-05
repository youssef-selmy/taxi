import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';
import 'package:admin_frontend/features/parking/parking_overview/data/graphql/parking_overview.graphql.dart';
import 'package:admin_frontend/features/parking/parking_overview/data/repositories/parking_overview_repository.dart';

@prod
@LazySingleton(as: ParkingOverviewRepository)
class ParkingOverviewRepositoryImpl implements ParkingOverviewRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkingOverviewRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$activeOrders>> getActiveOrders({
    required String currency,
  }) async {
    final ordersOrError = await graphQLDatasource.query(
      Options$Query$activeOrders(
        variables: Variables$Query$activeOrders(currency: currency),
      ),
    );
    return ordersOrError;
  }

  @override
  Future<ApiResponse<Query$overviewKPIs>> getKPIs({
    required String currency,
  }) async {
    final kpisOrError = await graphQLDatasource.query(
      Options$Query$overviewKPIs(
        variables: Variables$Query$overviewKPIs(currency: currency),
      ),
    );
    return kpisOrError;
  }

  @override
  Future<ApiResponse<Query$pendingParkings>> getPendingParkings() async {
    final pendingParkingsOrError = await graphQLDatasource.query(
      Options$Query$pendingParkings(),
    );
    return pendingParkingsOrError;
  }

  @override
  Future<ApiResponse<Query$pendingSupportRequests>>
  getPendingSupportRequets() async {
    final pendingSupportRequestsOrError = await graphQLDatasource.query(
      Options$Query$pendingSupportRequests(),
    );
    return pendingSupportRequestsOrError;
  }

  @override
  Future<ApiResponse<List<Fragment$leaderboardItem>>> getTopEarningParkings({
    required String currency,
  }) async {
    final topEarningParkingsOrError = await graphQLDatasource.query(
      Options$Query$topEarningParkings(
        variables: Variables$Query$topEarningParkings(currency: currency),
      ),
    );
    return topEarningParkingsOrError.mapData((r) => r.topEarningParkSpots);
  }

  @override
  Future<ApiResponse<List<Fragment$leaderboardItem>>>
  getTopSpendingCustomers() async {
    final topSpendingCustomersOrError = await graphQLDatasource.query(
      Options$Query$topSpendingCustomers(),
    );
    return topSpendingCustomersOrError.mapData((r) => r.topSpendingCustomers);
  }
}
