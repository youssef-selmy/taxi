import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/customer/customer_detail/data/graphql/customer_complaints_taxi.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class CustomerComplaintsTaxiRepository {
  Future<ApiResponse<Query$customerComplaintsTaxi>> getCustomerComplaintsTaxi({
    required Input$OffsetPaging? paging,
    required Input$TaxiSupportRequestFilter filter,
    required List<Input$TaxiSupportRequestSort> sorting,
  });
}
