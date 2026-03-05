import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/parking_order_support_request.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_complaints/data/graphql/parking_order_detail_complaints.graphql.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_complaints/data/repositories/parking_order_detail_complaints_repository.dart';

@dev
@LazySingleton(as: ParkingOrderDetailComplaintsRepository)
class ParkingOrderDetailComplaintsRepositoryMock
    implements ParkingOrderDetailComplaintsRepository {
  @override
  Future<ApiResponse<Query$getParkingOrderSupportRequest>>
  getParkingOrderDetailCpmplaints({required String parkingOrderId}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$getParkingOrderSupportRequest(
        parkingOrderComplaints:
            Query$getParkingOrderSupportRequest$parkingOrderComplaints(
              nodes: mockParkingOrderSupportRequestList,
            ),
      ),
    );
  }
}
