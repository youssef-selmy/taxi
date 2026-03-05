import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';
import 'package:admin_frontend/features/management_common/staff/data/graphql/staff_role.graphql.dart';
import 'package:admin_frontend/features/management_common/staff/data/repositories/staff_role_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: StaffRoleRepository)
class StaffRoleRepositoryImpl implements StaffRoleRepository {
  final GraphqlDatasource graphQLDatasource;

  StaffRoleRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$staffRoles>> getAll({
    required Input$OperatorRoleFilter filter,
    required List<Input$OperatorRoleSort> sorting,
  }) async {
    final staffRoles = await graphQLDatasource.query(
      Options$Query$staffRoles(
        variables: Variables$Query$staffRoles(sorting: sorting, filter: filter),
      ),
    );
    return staffRoles;
  }

  @override
  Future<ApiResponse<Fragment$staffRole>> getOne({required String id}) async {
    final staffRole = await graphQLDatasource.query(
      Options$Query$staffRoleDetails(
        variables: Variables$Query$staffRoleDetails(id: id),
      ),
    );
    return staffRole.mapData((f) => f.operatorRole);
  }

  @override
  Future<ApiResponse<Fragment$staffRole>> update({
    required String id,
    required Input$OperatorRoleInput input,
  }) async {
    final staffRole = await graphQLDatasource.mutate(
      Options$Mutation$updateStaffRole(
        variables: Variables$Mutation$updateStaffRole(id: id, input: input),
      ),
    );
    return staffRole.mapData((f) => f.updateOneOperatorRole);
  }

  @override
  Future<ApiResponse<Fragment$staffRole>> create({
    required Input$OperatorRoleInput input,
  }) async {
    final staffRole = await graphQLDatasource.mutate(
      Options$Mutation$createStaffRole(
        variables: Variables$Mutation$createStaffRole(input: input),
      ),
    );
    return staffRole.mapData((f) => f.createOneOperatorRole);
  }

  @override
  Future<ApiResponse<bool>> delete({required String id}) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$deleteStaffRole(
        variables: Variables$Mutation$deleteStaffRole(id: id),
      ),
    );
    return result.mapData((r) => true);
  }
}
