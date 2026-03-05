import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/taxi_support_request.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_detail/data/graphql/taxi_support_request_detail.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class TaxiSupportRequestDetailRepository {
  Future<ApiResponse<Query$taxiSupportRequest>> getSupportRequest({
    required String id,
  });

  Future<ApiResponse<Fragment$taxiSupportRequestActivity>> addComment({
    required Input$CreateTaxiSupportRequestCommentInput input,
  });

  Future<ApiResponse<Fragment$taxiSupportRequestActivity>> assignToStaffs({
    required Input$AssignTaxiSupportRequestInput input,
  });

  Future<ApiResponse<Fragment$taxiSupportRequestActivity>> updateStatus({
    required Input$ChangeTaxiSupportRequestStatusInput input,
  });
}
