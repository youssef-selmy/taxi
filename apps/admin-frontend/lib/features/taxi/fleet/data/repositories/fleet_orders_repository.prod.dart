import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_orders.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/repositories/fleet_orders_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: FleetOrdersRepository)
class FleetOrdersRepositoryImpl implements FleetOrdersRepository {
  final GraphqlDatasource graphQLDatasource;

  FleetOrdersRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$fleetOrders>> getFleetOrders({
    required Input$OffsetPaging? paging,
    required Input$OrderFilter filter,
    required List<Input$OrderSort> sorting,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$fleetOrders(
        variables: Variables$Query$fleetOrders(
          paging: paging,
          sorting: sorting,
          filter: filter,
        ),
      ),
    );
    return result;
  }

  @override
  Future<ApiResponse<String>> exportOrders({
    required List<Input$OrderSort> sort,
    required Input$OrderFilter filter,
    required Enum$ExportFormat format,
  }) async {
    final exportResult = await graphQLDatasource.query(
      Options$Query$exportFleetOrders(
        variables: Variables$Query$exportFleetOrders(
          sorting: sort,
          filter: filter,
          format: format,
        ),
      ),
    );
    return exportResult.mapData((data) => data.exportOrders);
  }
}
