import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/driver_sessions.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_active_devices/data/graphql/driver_detail_active_devices.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_active_devices/data/repositories/driver_detail_active_devices_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: DriverDetailActiveDevicesRepository)
class DriverDetailActiveDevicesRepositoryMock
    implements DriverDetailActiveDevicesRepository {
  @override
  Future<ApiResponse<Query$driverActiveDevices>> getDriverActiveDevices({
    required String driverId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$driverActiveDevices(driverActiveDevices: mockDriverSessionsList),
    );
  }

  @override
  Future<ApiResponse<Mutation$deleteDriverActiveDevice>>
  deleteDriverActiveDevice({
    required Input$DeleteOneDriverSessionInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$deleteDriverActiveDevice(
        deleteOneDriverSession:
            Mutation$deleteDriverActiveDevice$deleteOneDriverSession(
              id: '3',
              driverId: '1',
            ),
      ),
    );
  }
}
