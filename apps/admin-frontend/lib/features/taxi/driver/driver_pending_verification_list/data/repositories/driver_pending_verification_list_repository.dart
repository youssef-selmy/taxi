import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_list/data/graphql/driver_pending_verification_list.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class DriverPendingVerificationListRepository {
  Future<ApiResponse<Query$drivers>> getDrivers({
    required Input$OffsetPaging? paging,
    required Input$DriverFilter filter,
    required List<Input$DriverSort> sorting,
  });
}
