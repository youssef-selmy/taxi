import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail_orders.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_orders_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ParkSpotDetailOrdersRepository)
class ParkSpotDetailOrdersRepositoryMock
    implements ParkSpotDetailOrdersRepository {
  @override
  Future<ApiResponse<Query$parkSpotActiveOrders>> getParkSpotActiveOrders({
    required String parkSpotId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkSpotActiveOrders(
        parkOrders: Query$parkSpotActiveOrders$parkOrders(
          nodes: mockParkingOrderListItems,
          pageInfo: mockPageInfo,
          totalCount: mockParkingOrderListItems.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$parkSpotOrders>> getParkSpotOrders({
    required Input$ParkOrderFilter filter,
    required Input$OffsetPaging? paging,
    required List<Input$ParkOrderSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkSpotOrders(
        parkOrders: Query$parkSpotOrders$parkOrders(
          nodes: mockParkingOrderListItems,
          pageInfo: mockPageInfo,
          totalCount: mockParkingOrderListItems.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$parkOrderDetail>> getOrderDetail({
    required String orderId,
  }) async {
    return ApiResponse.loaded(
      Query$parkOrderDetail(
        parkOrder: mockParkingOrderDetail,
        parkSpotDetail: Query$parkOrderDetail$parkSpotDetail(
          parkSpot: mockParkSpotDetail,
        ),
      ),
    );
  }
}
