import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail_orders.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ParkSpotDetailOrdersRepository {
  Future<ApiResponse<Query$parkSpotOrders>> getParkSpotOrders({
    required Input$ParkOrderFilter filter,
    required Input$OffsetPaging? paging,
    required List<Input$ParkOrderSort> sorting,
  });

  Future<ApiResponse<Query$parkSpotActiveOrders>> getParkSpotActiveOrders({
    required String parkSpotId,
  });

  Future<ApiResponse<Query$parkOrderDetail>> getOrderDetail({
    required String orderId,
  });
}
