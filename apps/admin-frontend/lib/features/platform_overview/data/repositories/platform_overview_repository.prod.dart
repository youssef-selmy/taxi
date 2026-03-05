import 'package:admin_frontend/features/platform_overview/data/graphql/platform_overview.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';

import 'package:admin_frontend/features/platform_overview/domain/repositories/platform_overview_repository.dart';

@prod
@LazySingleton(as: PlatformOverviewRepository)
class PlatformOverviewRepositoryImpl implements PlatformOverviewRepository {
  final GraphqlDatasource graphQLDatasource;

  PlatformOverviewRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$pendingSupportRequestsCount>>
  getpendingSupportRequestsCount() {
    final pendingSupportRequestOrError = graphQLDatasource.query(
      Options$Query$pendingSupportRequestsCount(),
    );
    return pendingSupportRequestOrError;
  }

  @override
  Future<ApiResponse<Query$pendingOrders>> getPendingOrders() {
    final pendingOrdersOrError = graphQLDatasource.query(
      Options$Query$pendingOrders(),
    );
    return pendingOrdersOrError;
  }

  @override
  Future<ApiResponse<Query$platfromOverviewKPIs>> getOverviewKPIs({
    required String currency,
    required Enum$KPIPeriod period,
  }) {
    final overviewKPIsOrError = graphQLDatasource.query(
      Options$Query$platfromOverviewKPIs(
        variables: Variables$Query$platfromOverviewKPIs(
          currency: currency,
          period: period,
        ),
      ),
    );
    return overviewKPIsOrError;
  }

  @override
  Future<ApiResponse<Query$parkingOrders>> getParkingOrders({
    required Input$OffsetPaging? paging,
    required Input$ParkOrderFilter filter,
    required List<Input$ParkOrderSort> sorting,
  }) {
    final parkingOrdersOrError = graphQLDatasource.query(
      Options$Query$parkingOrders(
        variables: Variables$Query$parkingOrders(
          sorting: sorting,
          filter: filter,
          paging: paging,
        ),
      ),
    );
    return parkingOrdersOrError;
  }

  @override
  Future<ApiResponse<Query$shopOrders>> getShopOrders({
    required Input$OffsetPaging? paging,
    required Input$ShopOrderFilter filter,
    required List<Input$ShopOrderSort> sorting,
  }) {
    final shopOrdersOrError = graphQLDatasource.query(
      Options$Query$shopOrders(
        variables: Variables$Query$shopOrders(
          sorting: sorting,
          filter: filter,
          paging: paging,
        ),
      ),
    );
    return shopOrdersOrError;
  }

  @override
  Future<ApiResponse<Query$orderVolumeTimeSeries>> getOrderVolumeTimeSeries({
    required Enum$KPIPeriod period,
  }) async {
    final orderVolumeTimeSeries = await graphQLDatasource.query(
      Options$Query$orderVolumeTimeSeries(
        variables: Variables$Query$orderVolumeTimeSeries(period: period),
      ),
    );
    return orderVolumeTimeSeries;
  }
}
