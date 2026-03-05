import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/driver.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_drivers.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/repositories/fleet_drivers_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: FleetDriversRepository)
class FleetDriversRepositoryMock implements FleetDriversRepository {
  @override
  Future<ApiResponse<Query$fleetDrivers>> getFleetDrivers({
    required Input$OffsetPaging? paging,
    required Input$DriverFilter filter,
    required List<Input$DriverSort> sorting,
    required String fleetId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$fleetDrivers(
        drivers: Query$fleetDrivers$drivers(
          nodes: mockDriverListItems,
          pageInfo: mockPageInfo,
          totalCount: mockDriverListItems.length,
        ),
      ),
    );
  }
}
