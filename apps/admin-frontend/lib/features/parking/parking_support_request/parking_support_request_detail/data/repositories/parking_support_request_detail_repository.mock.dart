import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/parking_support_request.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_support_request.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/staff.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_support_request/parking_support_request_detail/data/graphql/parking_support_request_detail.graphql.dart';
import 'package:admin_frontend/features/parking/parking_support_request/parking_support_request_detail/data/repositories/parking_support_request_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ParkingSupportRequestDetailRepository)
class ParkingSupportRequestDetailRepositoryMock
    implements ParkingSupportRequestDetailRepository {
  @override
  Future<ApiResponse<Query$parkingSupportRequest>> getSupportRequest({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkingSupportRequest(
        parkingSupportRequest: mockParkingSupportRequestDetail,
        staffs: Query$parkingSupportRequest$staffs(nodes: mockStaffList),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$parkingSupportRequestActivity>> addComment({
    required Input$CreateParkingSupportRequestCommentInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockParkingSupportRequestActivity1);
  }

  @override
  Future<ApiResponse<Fragment$parkingSupportRequestActivity>> assignToStaffs({
    required Input$AssignParkingSupportRequestInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockParkingSupportRequestActivity1);
  }

  @override
  Future<ApiResponse<Fragment$parkingSupportRequestActivity>> updateStatus({
    required Input$ChangeParkingSupportRequestStatusInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockParkingSupportRequestActivity1);
  }
}
