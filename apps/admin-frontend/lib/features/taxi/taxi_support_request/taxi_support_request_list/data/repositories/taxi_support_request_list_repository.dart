import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_list/data/graphql/taxi_support_request.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class TaxiSupportRequestRepository {
  Future<ApiResponse<Query$taxiSupportRequests>> getAll({
    required Input$OffsetPaging? paging,
    required Input$TaxiSupportRequestFilter filter,
    required List<Input$TaxiSupportRequestSort> sorting,
  });
}
