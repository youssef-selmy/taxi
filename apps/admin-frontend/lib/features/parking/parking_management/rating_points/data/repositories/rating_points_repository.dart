import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ParkingRatingPointsRepository {
  // read all
  Future<ApiResponse<List<Fragment$parkingFeedbackParameterListItem>>>
  getRatingPoints();

  // read one
  Future<ApiResponse<Fragment$parkingFeedbackParameterListItem>>
  getRatingPoint({required String id});

  // create
  Future<ApiResponse<Fragment$parkingFeedbackParameterListItem>>
  createRatingPoint({required Input$CreateParkingFeedbackParameter input});

  // update
  Future<ApiResponse<Fragment$parkingFeedbackParameterListItem>>
  updateRatingPoint({
    required String id,
    required Input$UpdateParkingFeedbackParameter input,
  });

  // delete
  Future<ApiResponse<bool>> deleteRatingPoint(String id);
}
