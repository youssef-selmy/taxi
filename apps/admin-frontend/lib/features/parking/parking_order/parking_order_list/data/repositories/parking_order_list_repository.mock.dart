import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_list/data/graphql/parking_order_list.graphql.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_list/data/repositories/parking_order_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ParkingOrderListRepository)
class ParkingOrderListRepositoryMock implements ParkingOrderListRepository {
  @override
  Future<ApiResponse<Query$parkingOrderList>> getParkingOrderList({
    required Input$OffsetPaging? paging,
    required Input$ParkOrderFilter filter,
    required List<Input$ParkOrderSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkingOrderList(
        parkOrders: Query$parkingOrderList$parkOrders(
          totalCount: mockParkingOrderListItems.length,
          pageInfo: mockPageInfo,
          nodes: mockParkingOrderListItems,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$getParkingOrdersOverview>>
  getShopOrderStatistics() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$getParkingOrdersOverview(
        groupByStatus: [
          Query$getParkingOrdersOverview$groupByStatus(
            count: Query$getParkingOrdersOverview$groupByStatus$count(id: 120),
            groupBy: Query$getParkingOrdersOverview$groupByStatus$groupBy(
              status: Enum$ParkOrderStatus.ACCEPTED,
            ),
          ),
          Query$getParkingOrdersOverview$groupByStatus(
            count: Query$getParkingOrdersOverview$groupByStatus$count(id: 543),
            groupBy: Query$getParkingOrdersOverview$groupByStatus$groupBy(
              status: Enum$ParkOrderStatus.COMPLETED,
            ),
          ),
          Query$getParkingOrdersOverview$groupByStatus(
            count: Query$getParkingOrdersOverview$groupByStatus$count(id: 254),
            groupBy: Query$getParkingOrdersOverview$groupByStatus$groupBy(
              status: Enum$ParkOrderStatus.CANCELLED,
            ),
          ),
          Query$getParkingOrdersOverview$groupByStatus(
            count: Query$getParkingOrdersOverview$groupByStatus$count(id: 612),
            groupBy: Query$getParkingOrdersOverview$groupByStatus$groupBy(
              status: Enum$ParkOrderStatus.PAID,
            ),
          ),
          Query$getParkingOrdersOverview$groupByStatus(
            count: Query$getParkingOrdersOverview$groupByStatus$count(id: 345),
            groupBy: Query$getParkingOrdersOverview$groupByStatus$groupBy(
              status: Enum$ParkOrderStatus.PENDING,
            ),
          ),
          Query$getParkingOrdersOverview$groupByStatus(
            count: Query$getParkingOrdersOverview$groupByStatus$count(id: 87),
            groupBy: Query$getParkingOrdersOverview$groupByStatus$groupBy(
              status: Enum$ParkOrderStatus.REJECTED,
            ),
          ),
        ],
      ),
    );
  }
}
