import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.mock.dart';
import 'package:admin_frontend/features/management_common/staff/data/graphql/staff.graphql.dart';
import 'package:admin_frontend/features/management_common/staff/data/repositories/staff_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: StaffRepository)
class StaffRepositoryMock implements StaffRepository {
  @override
  Future<ApiResponse<Query$staffs>> getAll({
    required Input$OffsetPaging? paging,
    required Input$OperatorFilter filter,
    required List<Input$OperatorSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$staffs(
        staffs: Query$staffs$staffs(
          totalCount: mockStaffList.length,
          pageInfo: mockPageInfo,
          nodes: mockStaffList,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$staffDetails>> getOne({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockStaffDetails);
  }

  @override
  Future<ApiResponse<Fragment$staffDetails>> update({
    required String id,
    required Input$UpdateOperatorInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockStaffDetails);
  }

  @override
  Future<ApiResponse<Fragment$staffDetails>> create({
    required Input$CreateOperatorInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockStaffDetails);
  }

  @override
  Future<ApiResponse<List<Fragment$staffSession>>> getSessions({
    required Input$OperatorFilter filter,
    required List<Input$OperatorSessionSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockStaffSessionList);
  }

  @override
  Future<ApiResponse<Mutation$terminateStaffSession>> terminateSession({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$terminateStaffSession(terminateStaffSession: true),
    );
  }

  @override
  Future<ApiResponse<void>> delete({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(null);
  }
}
