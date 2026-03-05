import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';
import 'package:admin_frontend/features/management_common/staff/data/graphql/staff.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class StaffRepository {
  Future<ApiResponse<Query$staffs>> getAll({
    required Input$OffsetPaging? paging,
    required Input$OperatorFilter filter,
    required List<Input$OperatorSort> sorting,
  });

  Future<ApiResponse<Fragment$staffDetails>> getOne({required String id});

  Future<ApiResponse<Fragment$staffDetails>> update({
    required String id,
    required Input$UpdateOperatorInput input,
  });
  Future<ApiResponse<Fragment$staffDetails>> create({
    required Input$CreateOperatorInput input,
  });

  Future<ApiResponse<List<Fragment$staffSession>>> getSessions({
    required Input$OperatorFilter filter,
    required List<Input$OperatorSessionSort> sorting,
  });

  Future<ApiResponse<Mutation$terminateStaffSession>> terminateSession({
    required String id,
  });

  Future<ApiResponse<void>> delete({required String id});
}
