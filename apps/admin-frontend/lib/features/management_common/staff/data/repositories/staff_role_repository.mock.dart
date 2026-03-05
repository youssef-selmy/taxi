import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.mock.dart';
import 'package:admin_frontend/features/management_common/staff/data/graphql/staff_role.graphql.dart';
import 'package:admin_frontend/features/management_common/staff/data/repositories/staff_role_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: StaffRoleRepository)
class StaffRoleRepositoryMock implements StaffRoleRepository {
  @override
  Future<ApiResponse<Query$staffRoles>> getAll({
    required Input$OperatorRoleFilter filter,
    required List<Input$OperatorRoleSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(Query$staffRoles(staffRoles: staffRoles));
  }

  @override
  Future<ApiResponse<Fragment$staffRole>> getOne({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockStaffRole1);
  }

  @override
  Future<ApiResponse<Fragment$staffRole>> update({
    required String id,
    required Input$OperatorRoleInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockStaffRole1);
  }

  @override
  Future<ApiResponse<Fragment$staffRole>> create({
    required Input$OperatorRoleInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockStaffRole1);
  }

  @override
  Future<ApiResponse<bool>> delete({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const ApiResponse.loaded(true);
  }
}
