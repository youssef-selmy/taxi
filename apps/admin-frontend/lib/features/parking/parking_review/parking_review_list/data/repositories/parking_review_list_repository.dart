import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.dart';
import 'package:admin_frontend/features/parking/parking_review/parking_review_list/data/graphql/parking_review_list.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ParkingReviewListRepository {
  Future<ApiResponse<Query$parkingFeedbacks>> getParkingReviewsList({
    required Input$OffsetPaging? paging,
    required Input$ParkingFeedbackFilter filter,
    required List<Input$ParkingFeedbackSort> sorting,
  });

  Future<ApiResponse<Fragment$parkingFeedback>> updateParkingFeedbackStatus({
    required String id,
    required Enum$ReviewStatus status,
  });
}
