import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_complaints/data/graphql/parking_order_detail_complaints.graphql.dart';

abstract class ParkingOrderDetailComplaintsRepository {
  Future<ApiResponse<Query$getParkingOrderSupportRequest>>
  getParkingOrderDetailCpmplaints({required String parkingOrderId});
}
