import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/orders_parking.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/orders_parking_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: OrdersParkingRepository)
class OrdersParkingRepositoryMock implements OrdersParkingRepository {
  @override
  Future<ApiResponse<Query$customerOrdersParking>> getAll({
    required Input$ParkOrderFilter filter,
    required Input$OffsetPaging? paging,
    required List<Input$ParkOrderSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$customerOrdersParking(
        parkOrders: Query$customerOrdersParking$parkOrders(
          nodes: mockParkingOrderListItems,
          pageInfo: mockPageInfo,
          totalCount: mockParkingOrderListItems.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<String>> export({
    required List<Input$ParkOrderSort> sort,
    required Input$ParkOrderFilter filter,
    required Enum$ExportFormat format,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded('exported_data');
  }
}
