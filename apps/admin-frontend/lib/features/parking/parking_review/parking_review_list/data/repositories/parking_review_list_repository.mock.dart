import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_review/parking_review_list/data/graphql/parking_review_list.graphql.dart';
import 'package:admin_frontend/features/parking/parking_review/parking_review_list/data/repositories/parking_review_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ParkingReviewListRepository)
class ParkingReviewListRepositoryMock implements ParkingReviewListRepository {
  @override
  Future<ApiResponse<Query$parkingFeedbacks>> getParkingReviewsList({
    required Input$OffsetPaging? paging,
    required Input$ParkingFeedbackFilter filter,
    required List<Input$ParkingFeedbackSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkingFeedbacks(
        parkingFeedbacks: Query$parkingFeedbacks$parkingFeedbacks(
          pageInfo: mockPageInfo,
          totalCount: mockParkingFeedbacks.length,
          nodes: mockParkingFeedbacks,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$parkingFeedback>> updateParkingFeedbackStatus({
    required String id,
    required Enum$ReviewStatus status,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockParkingFeedback1);
  }
}
