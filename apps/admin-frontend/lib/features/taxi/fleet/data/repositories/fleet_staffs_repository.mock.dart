import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_session.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_staffs.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/repositories/fleet_staffs_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: FleetStaffsRepository)
class FleetStaffsRepositoryMock implements FleetStaffsRepository {
  @override
  Future<ApiResponse<Query$fleetStaffList>> getFleetStaffs({
    required Input$OffsetPaging? paging,
    required Input$FleetStaffFilter filter,
    required List<Input$FleetStaffSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$fleetStaffList(
        fleetStaffs: Query$fleetStaffList$fleetStaffs(
          totalCount: mockFLeetStaffsList.length,
          pageInfo: mockPageInfo,
          nodes: mockFLeetStaffsList,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$fleetStaffs>> getFleetStaffDetails({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockFleetStaff1);
  }

  @override
  Future<ApiResponse<Fragment$fleetStaffs>> createFleetStaff({
    required Input$CreateOneFleetStaffInput data,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockFleetStaff1);
  }

  @override
  Future<ApiResponse<Fragment$fleetStaffs>> updateFleetStaff({
    required Input$UpdateOneFleetStaffInput data,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockFleetStaff1);
  }

  @override
  Future<ApiResponse<Query$fleetStaffSession>> getFleetStaffSession() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$fleetStaffSession(fleetStaffSessions: mockFleetStaffSessionList),
    );
  }

  @override
  Future<ApiResponse<void>> terminateSession({
    required String sessionId,
  }) async {
    return ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<void>> deleteFleetStaff({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(null);
  }
}
