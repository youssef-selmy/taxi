import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';

abstract class RatingPointInsightsRepository {
  Future<ApiResponse<List<Fragment$nameCount>>> getRatingPointInsights();
}
