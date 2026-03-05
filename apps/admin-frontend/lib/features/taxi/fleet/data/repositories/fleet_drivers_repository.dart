import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_drivers.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class FleetDriversRepository {
  Future<ApiResponse<Query$fleetDrivers>> getFleetDrivers({
    required Input$OffsetPaging? paging,
    required Input$DriverFilter filter,
    required List<Input$DriverSort> sorting,
    required String fleetId,
  });
}
