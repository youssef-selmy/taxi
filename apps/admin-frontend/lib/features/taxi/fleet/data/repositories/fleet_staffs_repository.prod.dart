import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_session.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_staffs.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/repositories/fleet_staffs_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: FleetStaffsRepository)
class FleetStaffsRepositoryImpl implements FleetStaffsRepository {
  final GraphqlDatasource graphQLDatasource;

  FleetStaffsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$fleetStaffList>> getFleetStaffs({
    required Input$OffsetPaging? paging,
    required Input$FleetStaffFilter filter,
    required List<Input$FleetStaffSort> sorting,
  }) async {
    final fleetStaffs = await graphQLDatasource.query(
      Options$Query$fleetStaffList(
        variables: Variables$Query$fleetStaffList(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return fleetStaffs;
  }

  @override
  Future<ApiResponse<Fragment$fleetStaffs>> getFleetStaffDetails({
    required String id,
  }) async {
    final staff = await graphQLDatasource.query(
      Options$Query$fleetStaffDetails(
        variables: Variables$Query$fleetStaffDetails(id: id),
      ),
    );

    return staff.mapData((f) => f.fleetStaff);
  }

  @override
  Future<ApiResponse<Fragment$fleetStaffs>> createFleetStaff({
    required Input$CreateOneFleetStaffInput data,
  }) async {
    final staff = await graphQLDatasource.mutate(
      Options$Mutation$createFleetStaff(
        variables: Variables$Mutation$createFleetStaff(input: data),
      ),
    );
    return staff.mapData((f) => f.createOneFleetStaff);
  }

  @override
  Future<ApiResponse<Fragment$fleetStaffs>> updateFleetStaff({
    required Input$UpdateOneFleetStaffInput data,
  }) async {
    final staff = await graphQLDatasource.mutate(
      Options$Mutation$updateFleetStaff(
        variables: Variables$Mutation$updateFleetStaff(input: data),
      ),
    );
    return staff.mapData((f) => f.updateOneFleetStaff);
  }

  @override
  Future<ApiResponse<Query$fleetStaffSession>> getFleetStaffSession() async {
    final fleetStaffSession = await graphQLDatasource.query(
      Options$Query$fleetStaffSession(),
    );
    return fleetStaffSession;
  }

  @override
  Future<ApiResponse<void>> terminateSession({
    required String sessionId,
  }) async {
    final terminateOrError = await graphQLDatasource.mutate(
      Options$Mutation$terminateFleetStaffSession(
        variables: Variables$Mutation$terminateFleetStaffSession(id: sessionId),
      ),
    );
    return terminateOrError;
  }

  @override
  Future<ApiResponse<void>> deleteFleetStaff({required String id}) async {
    final deleteOrError = await graphQLDatasource.mutate(
      Options$Mutation$deleteFleetStaff(
        variables: Variables$Mutation$deleteFleetStaff(id: id),
      ),
    );
    return deleteOrError;
  }
}
