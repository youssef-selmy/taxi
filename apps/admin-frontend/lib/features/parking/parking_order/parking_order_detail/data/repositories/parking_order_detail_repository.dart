import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.dart';

abstract class ParkingOrderDetailRepository {
  Future<ApiResponse<Fragment$parkingOrderDetail>> getParkingOrderDetail({
    required String id,
  });
}
