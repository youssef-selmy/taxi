import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/driver/driver_list/data/graphql/driver_list.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class DriverListRepository {
  Future<ApiResponse<Query$drivers>> getDrivers({
    required Input$OffsetPaging? paging,
    required Input$DriverFilter filter,
    required List<Input$DriverSort> sorting,
  });

  Future<ApiResponse<Mutation$updateOneDriver>> updateDriver({
    required Input$UpdateOneDriverInput input,
  });

  Future<ApiResponse<Mutation$updateDriverStatus>> updateDriverStatus({
    required String id,
    required Enum$DriverStatus status,
  });
}
