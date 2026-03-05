import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_order.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/data/repositories/parking_order_detail_repository.dart';

@dev
@LazySingleton(as: ParkingOrderDetailRepository)
class ParkingOrderDetailRepositoryMock implements ParkingOrderDetailRepository {
  @override
  Future<ApiResponse<Fragment$parkingOrderDetail>> getParkingOrderDetail({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockParkingOrderDetail);
  }
}
