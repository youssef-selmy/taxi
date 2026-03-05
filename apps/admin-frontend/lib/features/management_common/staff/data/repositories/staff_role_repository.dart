import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';
import 'package:admin_frontend/features/management_common/staff/data/graphql/staff_role.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class StaffRoleRepository {
  Future<ApiResponse<Query$staffRoles>> getAll({
    required Input$OperatorRoleFilter filter,
    required List<Input$OperatorRoleSort> sorting,
  });

  Future<ApiResponse<Fragment$staffRole>> getOne({required String id});

  Future<ApiResponse<Fragment$staffRole>> update({
    required String id,
    required Input$OperatorRoleInput input,
  });

  Future<ApiResponse<Fragment$staffRole>> create({
    required Input$OperatorRoleInput input,
  });

  Future<ApiResponse<bool>> delete({required String id});
}
