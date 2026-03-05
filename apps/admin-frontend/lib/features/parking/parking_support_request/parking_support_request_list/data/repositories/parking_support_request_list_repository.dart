import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/parking/parking_support_request/parking_support_request_list/data/graphql/parking_support_request.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ParkingSupportRequestRepository {
  Future<ApiResponse<Query$parkingSupportRequests>> getAll({
    required Input$OffsetPaging? paging,
    required Input$ParkingSupportRequestFilter filter,
    required List<Input$ParkingSupportRequestSort> sorting,
  });
}
