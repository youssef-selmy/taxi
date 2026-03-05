import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/review_taxi.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class RatingPointsRepository {
  // read all
  Future<ApiResponse<List<Fragment$reviewTaxiParameterListItem>>>
  getRatingPoints();

  // read one
  Future<ApiResponse<Fragment$reviewTaxiParameterListItem>> getRatingPoint({
    required String id,
  });

  // create
  Future<ApiResponse<Fragment$reviewTaxiParameterListItem>> createRatingPoint({
    required Input$FeedbackParameterInput input,
  });

  // update
  Future<ApiResponse<Fragment$reviewTaxiParameterListItem>> updateRatingPoint({
    required String id,
    required Input$FeedbackParameterInput input,
  });

  // delete
  Future<ApiResponse<bool>> deleteRatingPoint(String id);
}
