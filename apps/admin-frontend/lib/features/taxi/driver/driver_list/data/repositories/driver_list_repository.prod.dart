import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/data/graphql/driver_list.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/data/repositories/driver_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: DriverListRepository)
class DriverListRepositoryImpl implements DriverListRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverListRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$drivers>> getDrivers({
    required Input$OffsetPaging? paging,
    required Input$DriverFilter filter,
    required List<Input$DriverSort> sorting,
  }) async {
    final getDriversListOrError = await graphQLDatasource.query(
      Options$Query$drivers(
        variables: Variables$Query$drivers(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return getDriversListOrError;
  }

  @override
  Future<ApiResponse<Mutation$updateOneDriver>> updateDriver({
    required Input$UpdateOneDriverInput input,
  }) async {
    final updateDriverOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateOneDriver(
        variables: Variables$Mutation$updateOneDriver(input: input),
      ),
    );
    return updateDriverOrError;
  }

  @override
  Future<ApiResponse<Mutation$updateDriverStatus>> updateDriverStatus({
    required String id,
    required Enum$DriverStatus status,
  }) async {
    final updateDriverStatusOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateDriverStatus(
        variables: Variables$Mutation$updateDriverStatus(
          id: id,
          status: status,
        ),
      ),
    );
    return updateDriverStatusOrError;
  }
}
