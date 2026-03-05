import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/parking/parking_order/parking_order_list/data/graphql/parking_order_list.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ParkingOrderListRepository {
  Future<ApiResponse<Query$parkingOrderList>> getParkingOrderList({
    required Input$OffsetPaging? paging,
    required Input$ParkOrderFilter filter,
    required List<Input$ParkOrderSort> sorting,
  });

  Future<ApiResponse<Query$getParkingOrdersOverview>> getShopOrderStatistics();
}
