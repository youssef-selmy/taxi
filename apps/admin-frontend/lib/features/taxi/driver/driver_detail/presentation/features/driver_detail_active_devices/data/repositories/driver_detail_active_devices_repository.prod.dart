import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_active_devices/data/graphql/driver_detail_active_devices.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_active_devices/data/repositories/driver_detail_active_devices_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: DriverDetailActiveDevicesRepository)
class DriverDetailActiveDevicesRepositoryImpl
    implements DriverDetailActiveDevicesRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverDetailActiveDevicesRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$driverActiveDevices>> getDriverActiveDevices({
    required String driverId,
  }) async {
    final getDriverActiveDevicesOrError = await graphQLDatasource.query(
      Options$Query$driverActiveDevices(
        variables: Variables$Query$driverActiveDevices(id: driverId),
      ),
    );
    return getDriverActiveDevicesOrError;
  }

  @override
  Future<ApiResponse<Mutation$deleteDriverActiveDevice>>
  deleteDriverActiveDevice({
    required Input$DeleteOneDriverSessionInput input,
  }) async {
    final deleteDriverActiveDeviceOrError = await graphQLDatasource.mutate(
      Options$Mutation$deleteDriverActiveDevice(
        variables: Variables$Mutation$deleteDriverActiveDevice(input: input),
      ),
    );
    return deleteDriverActiveDeviceOrError;
  }
}
