import 'dart:math';

import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/review_taxi.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_management/rating_points/data/repositories/rating_point_insights_repository.dart';

@dev
@LazySingleton(as: RatingPointInsightsRepository)
class RatingPointInsightsRepositoryMock
    implements RatingPointInsightsRepository {
  @override
  Future<ApiResponse<List<Fragment$nameCount>>> getRatingPointInsights() async {
    return ApiResponse.loaded(mockRatingPointInsights);
  }
}

final mockRatingPointInsights = mockReviewTaxiParameterListItems
    .map(
      (e) => Fragment$nameCount(
        name: e.title,
        count: (500 + (Random().nextInt(1000))),
      ),
    )
    .toList();
