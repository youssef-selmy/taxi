import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/cancel_reason.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/cancel_reason.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/data/repositories/cancel_reason_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: CancelReasonRepository)
class CancelReasonRepositoryMock implements CancelReasonRepository {
  @override
  Future<ApiResponse<List<Fragment$cancelReason>>> getCancelReasons() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockCancelReasonTaxi);
  }

  @override
  Future<ApiResponse<Fragment$cancelReason>> createCancelReason({
    required Input$OrderCancelReasonInput input,
  }) async {
    return ApiResponse.loaded(mockCancelReasonTaxi.first);
  }

  @override
  Future<ApiResponse<void>> deleteCancelReason({required String id}) async {
    return const ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<Fragment$cancelReason>> getCancelReason({
    required String id,
  }) async {
    return ApiResponse.loaded(mockCancelReasonTaxi.first);
  }

  @override
  Future<ApiResponse<Fragment$cancelReason>> updateCancelReason({
    required String id,
    required Input$OrderCancelReasonInput input,
  }) async {
    return ApiResponse.loaded(mockCancelReasonTaxi.first);
  }
}
