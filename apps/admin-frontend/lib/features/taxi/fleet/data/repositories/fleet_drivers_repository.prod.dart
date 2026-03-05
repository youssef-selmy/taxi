import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_drivers.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/repositories/fleet_drivers_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: FleetDriversRepository)
class FleetDriversRepositoryImpl implements FleetDriversRepository {
  final GraphqlDatasource graphQLDatasource;

  FleetDriversRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$fleetDrivers>> getFleetDrivers({
    required Input$OffsetPaging? paging,
    required Input$DriverFilter filter,
    required List<Input$DriverSort> sorting,
    required String fleetId,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$fleetDrivers(
        variables: Variables$Query$fleetDrivers(
          paging: paging,
          sorting: sorting,
          filter: filter,
        ),
      ),
    );
    return result;
  }
}
