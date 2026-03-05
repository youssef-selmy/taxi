import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/review_taxi.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/review_taxi.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_management/rating_points/data/repositories/rating_points_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: RatingPointsRepository)
class RatingPointsRepositoryMock implements RatingPointsRepository {
  @override
  Future<ApiResponse<List<Fragment$reviewTaxiParameterListItem>>>
  getRatingPoints() async {
    return ApiResponse.loaded(mockReviewTaxiParameterListItems);
  }

  @override
  Future<ApiResponse<Fragment$reviewTaxiParameterListItem>> createRatingPoint({
    required Input$FeedbackParameterInput input,
  }) async {
    return ApiResponse.loaded(mockReviewTaxiParameterListItem1);
  }

  @override
  Future<ApiResponse<bool>> deleteRatingPoint(String id) async {
    return const ApiResponse.loaded(true);
  }

  @override
  Future<ApiResponse<Fragment$reviewTaxiParameterListItem>> getRatingPoint({
    required String id,
  }) async {
    return ApiResponse.loaded(mockReviewTaxiParameterListItem1);
  }

  @override
  Future<ApiResponse<Fragment$reviewTaxiParameterListItem>> updateRatingPoint({
    required String id,
    required Input$FeedbackParameterInput input,
  }) async {
    return ApiResponse.loaded(mockReviewTaxiParameterListItem1);
  }
}
