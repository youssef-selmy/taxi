import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_support_request.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/customer_complaints_parking.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/customer_complaints_parking_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: CustomerComplaintsParkingRepository)
class CustomerComplaintsParkingRepositoryMock
    implements CustomerComplaintsParkingRepository {
  @override
  Future<ApiResponse<Query$customerComplaintsParking>>
  getCustomerComplaintsParking({
    required Input$OffsetPaging? paging,
    required Input$ParkingSupportRequestFilter filter,
    required List<Input$ParkingSupportRequestSort> sorting,
  }) async {
    return ApiResponse.loaded(
      Query$customerComplaintsParking(
        parkingSupportRequests:
            Query$customerComplaintsParking$parkingSupportRequests(
              nodes: mockParkingSupportRequests,
              pageInfo: mockPageInfo,
              totalCount: mockParkingSupportRequests.length,
            ),
      ),
    );
  }
}
