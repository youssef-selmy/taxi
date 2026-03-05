import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_active_devices/data/graphql/driver_detail_active_devices.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class DriverDetailActiveDevicesRepository {
  Future<ApiResponse<Query$driverActiveDevices>> getDriverActiveDevices({
    required String driverId,
  });

  Future<ApiResponse<Mutation$deleteDriverActiveDevice>>
  deleteDriverActiveDevice({required Input$DeleteOneDriverSessionInput input});
}
