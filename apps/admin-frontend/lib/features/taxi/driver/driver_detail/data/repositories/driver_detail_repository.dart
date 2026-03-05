import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/driver/driver_detail/data/graphql/driver_detail.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class DriverDetailRepository {
  Future<ApiResponse<Query$driverDetail>> getDriverDetail({
    required String driverId,
  });

  Future<ApiResponse<Mutation$updateDriver>> updateDriver({
    required Input$UpdateOneDriverInput input,
  });

  Future<ApiResponse<Mutation$updateDriverService>> updateDriverService({
    required Input$SetActiveServicesOnDriverInput input,
  });

  Future<ApiResponse<Mutation$updateDriverStatusDetail>> updateDriverStatus({
    required String id,
    required Enum$DriverStatus status,
  });
}
