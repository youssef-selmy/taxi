import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';
import 'package:admin_frontend/features/management_common/staff/data/graphql/staff.graphql.dart';
import 'package:admin_frontend/features/management_common/staff/data/repositories/staff_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: StaffRepository)
class StaffRepositoryImpl implements StaffRepository {
  final GraphqlDatasource graphQLDatasource;

  StaffRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$staffs>> getAll({
    required Input$OffsetPaging? paging,
    required Input$OperatorFilter filter,
    required List<Input$OperatorSort> sorting,
  }) async {
    final staffs = await graphQLDatasource.query(
      Options$Query$staffs(
        variables: Variables$Query$staffs(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return staffs;
  }

  @override
  Future<ApiResponse<Fragment$staffDetails>> getOne({
    required String id,
  }) async {
    final staff = await graphQLDatasource.query(
      Options$Query$staffDetails(
        variables: Variables$Query$staffDetails(id: id),
      ),
    );

    return staff.mapData((f) => f.$operator);
  }

  @override
  Future<ApiResponse<Fragment$staffDetails>> update({
    required String id,
    required Input$UpdateOperatorInput input,
  }) async {
    final staff = await graphQLDatasource.mutate(
      Options$Mutation$updateOneStaff(
        variables: Variables$Mutation$updateOneStaff(id: id, input: input),
      ),
    );
    return staff.mapData((f) => f.updateOneOperator);
  }

  @override
  Future<ApiResponse<Fragment$staffDetails>> create({
    required Input$CreateOperatorInput input,
  }) async {
    final staff = await graphQLDatasource.mutate(
      Options$Mutation$createOneStaff(
        variables: Variables$Mutation$createOneStaff(input: input),
      ),
    );
    return staff.mapData((f) => f.createOneOperator);
  }

  @override
  Future<ApiResponse<List<Fragment$staffSession>>> getSessions({
    required Input$OperatorFilter filter,
    required List<Input$OperatorSessionSort> sorting,
  }) async {
    final session = await graphQLDatasource.query(
      Options$Query$staffSessions(
        variables: Variables$Query$staffSessions(sorting: sorting),
      ),
    );
    return session.mapData((f) => f.operatorSessions);
  }

  @override
  Future<ApiResponse<Mutation$terminateStaffSession>> terminateSession({
    required String id,
  }) async {
    final session = await graphQLDatasource.mutate(
      Options$Mutation$terminateStaffSession(
        variables: Variables$Mutation$terminateStaffSession(id: id),
      ),
    );
    return session;
  }

  @override
  Future<ApiResponse<void>> delete({required String id}) {
    return graphQLDatasource.mutate(
      Options$Mutation$deleteOneStaff(
        variables: Variables$Mutation$deleteOneStaff(id: id),
      ),
    );
  }
}
