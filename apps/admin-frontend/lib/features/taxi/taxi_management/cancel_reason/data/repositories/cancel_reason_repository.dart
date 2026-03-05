import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/cancel_reason.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class CancelReasonRepository {
  Future<ApiResponse<List<Fragment$cancelReason>>> getCancelReasons();

  Future<ApiResponse<Fragment$cancelReason>> getCancelReason({
    required String id,
  });

  Future<ApiResponse<Fragment$cancelReason>> createCancelReason({
    required Input$OrderCancelReasonInput input,
  });

  Future<ApiResponse<Fragment$cancelReason>> updateCancelReason({
    required String id,
    required Input$OrderCancelReasonInput input,
  });

  Future<ApiResponse<void>> deleteCancelReason({required String id});
}
