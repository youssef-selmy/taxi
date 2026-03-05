import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/data/graphql/cancel_reason_insights.graphql.dart';

abstract class CancelReasonInsightsRepository {
  Future<ApiResponse<Query$cancelReasonInsights>> getCancelReasonInsights();
}
