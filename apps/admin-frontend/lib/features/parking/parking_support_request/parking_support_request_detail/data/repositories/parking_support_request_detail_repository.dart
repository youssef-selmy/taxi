import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/parking_support_request.fragment.graphql.dart';
import 'package:admin_frontend/features/parking/parking_support_request/parking_support_request_detail/data/graphql/parking_support_request_detail.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ParkingSupportRequestDetailRepository {
  Future<ApiResponse<Query$parkingSupportRequest>> getSupportRequest({
    required String id,
  });

  Future<ApiResponse<Fragment$parkingSupportRequestActivity>> addComment({
    required Input$CreateParkingSupportRequestCommentInput input,
  });

  Future<ApiResponse<Fragment$parkingSupportRequestActivity>> assignToStaffs({
    required Input$AssignParkingSupportRequestInput input,
  });

  Future<ApiResponse<Fragment$parkingSupportRequestActivity>> updateStatus({
    required Input$ChangeParkingSupportRequestStatusInput input,
  });
}
