import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/customer/customer_detail/data/graphql/customer_complaints_parking.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class CustomerComplaintsParkingRepository {
  Future<ApiResponse<Query$customerComplaintsParking>>
  getCustomerComplaintsParking({
    required Input$OffsetPaging? paging,
    required Input$ParkingSupportRequestFilter filter,
    required List<Input$ParkingSupportRequestSort> sorting,
  });
}
