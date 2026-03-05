import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_support_request.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_support_request/parking_support_request_list/data/graphql/parking_support_request.graphql.dart';
import 'package:admin_frontend/features/parking/parking_support_request/parking_support_request_list/data/repositories/parking_support_request_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ParkingSupportRequestRepository)
class ParkingSupportRequestRepositoryMock
    implements ParkingSupportRequestRepository {
  @override
  Future<ApiResponse<Query$parkingSupportRequests>> getAll({
    required Input$OffsetPaging? paging,
    required Input$ParkingSupportRequestFilter filter,
    required List<Input$ParkingSupportRequestSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkingSupportRequests(
        parkingSupportRequests:
            Query$parkingSupportRequests$parkingSupportRequests(
              pageInfo: mockPageInfo,
              totalCount: mockParkingSupportRequests.length,
              nodes: mockParkingSupportRequests,
            ),
      ),
    );
  }
}
