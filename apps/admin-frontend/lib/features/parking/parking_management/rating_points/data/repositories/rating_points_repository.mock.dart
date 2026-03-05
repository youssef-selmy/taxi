import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_management/rating_points/data/repositories/rating_points_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ParkingRatingPointsRepository)
class ParkingRatingPointsRepositoryMock
    implements ParkingRatingPointsRepository {
  @override
  Future<ApiResponse<List<Fragment$parkingFeedbackParameterListItem>>>
  getRatingPoints() async {
    return ApiResponse.loaded(mockParkingReviewParameterListItems);
  }

  @override
  Future<ApiResponse<Fragment$parkingFeedbackParameterListItem>>
  createRatingPoint({
    required Input$CreateParkingFeedbackParameter input,
  }) async {
    return ApiResponse.loaded(mockParkingReviewParameterListItem1);
  }

  @override
  Future<ApiResponse<bool>> deleteRatingPoint(String id) async {
    return const ApiResponse.loaded(true);
  }

  @override
  Future<ApiResponse<Fragment$parkingFeedbackParameterListItem>>
  getRatingPoint({required String id}) async {
    return ApiResponse.loaded(mockParkingReviewParameterListItem1);
  }

  @override
  Future<ApiResponse<Fragment$parkingFeedbackParameterListItem>>
  updateRatingPoint({
    required String id,
    required Input$UpdateParkingFeedbackParameter input,
  }) async {
    return ApiResponse.loaded(mockParkingReviewParameterListItem1);
  }
}
