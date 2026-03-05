import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/shop_overview/data/graphql/shop_overview.graphql.dart';
import 'package:admin_frontend/features/shop/shop_overview/data/repositories/shop_overview_repository.dart';

@prod
@LazySingleton(as: ShopOverviewRepository)
class ShopOverviewRepositoryImpl implements ShopOverviewRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopOverviewRepositoryImpl(this.graphQLDatasource);

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
  Future<ApiResponse<Query$pendingShops>> getPendingShops() async {
    final pendingShopsOrError = await graphQLDatasource.query(
      Options$Query$pendingShops(),
    );
    return pendingShopsOrError;
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
  Future<ApiResponse<List<Fragment$leaderboardItem>>>
  getTopEarningShops() async {
    final topEarningShopsOrError = await graphQLDatasource.query(
      Options$Query$topEarningShops(),
    );
    return topEarningShopsOrError.mapData((r) => r.topEarningShops);
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
