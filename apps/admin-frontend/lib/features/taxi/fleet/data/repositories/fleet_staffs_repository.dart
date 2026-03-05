import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_session.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_staffs.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class FleetStaffsRepository {
  Future<ApiResponse<Query$fleetStaffList>> getFleetStaffs({
    required Input$OffsetPaging? paging,
    required Input$FleetStaffFilter filter,
    required List<Input$FleetStaffSort> sorting,
  });

  Future<ApiResponse<Fragment$fleetStaffs>> getFleetStaffDetails({
    required String id,
  });

  Future<ApiResponse<Fragment$fleetStaffs>> createFleetStaff({
    required Input$CreateOneFleetStaffInput data,
  });

  Future<ApiResponse<Fragment$fleetStaffs>> updateFleetStaff({
    required Input$UpdateOneFleetStaffInput data,
  });

  Future<ApiResponse<void>> deleteFleetStaff({required String id});

  Future<ApiResponse<Query$fleetStaffSession>> getFleetStaffSession();

  Future<ApiResponse<void>> terminateSession({required String sessionId});
}
