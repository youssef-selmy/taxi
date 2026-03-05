import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/data/graphql/driver_detail.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/data/repositories/driver_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: DriverDetailRepository)
class DriverDetailRepositoryImpl implements DriverDetailRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverDetailRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$driverDetail>> getDriverDetail({
    required String driverId,
  }) async {
    var getDriverDetailOrError = graphQLDatasource.query(
      Options$Query$driverDetail(
        variables: Variables$Query$driverDetail(id: driverId),
      ),
    );
    return getDriverDetailOrError;
  }

  @override
  Future<ApiResponse<Mutation$updateDriver>> updateDriver({
    required Input$UpdateOneDriverInput input,
  }) async {
    var updateDriverOrError = graphQLDatasource.mutate(
      Options$Mutation$updateDriver(
        variables: Variables$Mutation$updateDriver(input: input),
      ),
    );
    return updateDriverOrError;
  }

  @override
  Future<ApiResponse<Mutation$updateDriverService>> updateDriverService({
    required Input$SetActiveServicesOnDriverInput input,
  }) async {
    var updateDriverServiceOrError = graphQLDatasource.mutate(
      Options$Mutation$updateDriverService(
        variables: Variables$Mutation$updateDriverService(input: input),
      ),
    );
    return updateDriverServiceOrError;
  }

  @override
  Future<ApiResponse<Mutation$updateDriverStatusDetail>> updateDriverStatus({
    required String id,
    required Enum$DriverStatus status,
  }) async {
    final updateDriverStatusOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateDriverStatusDetail(
        variables: Variables$Mutation$updateDriverStatusDetail(
          id: id,
          status: status,
        ),
      ),
    );
    return updateDriverStatusOrError;
  }
}
