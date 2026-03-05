import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_complaints/data/graphql/taxi_order_detail_complaints.graphql.dart';

abstract class TaxiOrderDetailComplaintsRepository {
  Future<ApiResponse<Query$taxiOrderSupportRequests>> getTaxiOrderComplaints({
    required String id,
  });
}
