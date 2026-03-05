import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/staff.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_support_request.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_support_request.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_detail/data/graphql/taxi_support_request_detail.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_detail/data/repositories/taxi_support_request_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: TaxiSupportRequestDetailRepository)
class TaxiSupportRequestDetailRepositoryMock
    implements TaxiSupportRequestDetailRepository {
  @override
  Future<ApiResponse<Query$taxiSupportRequest>> getSupportRequest({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$taxiSupportRequest(
        taxiSupportRequest: mockTaxiSupportRequestDetail,
        staffs: Query$taxiSupportRequest$staffs(nodes: mockStaffList),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$taxiSupportRequestActivity>> addComment({
    required Input$CreateTaxiSupportRequestCommentInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockTaxiSupportRequestActivity1);
  }

  @override
  Future<ApiResponse<Fragment$taxiSupportRequestActivity>> assignToStaffs({
    required Input$AssignTaxiSupportRequestInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockTaxiSupportRequestActivity1);
  }

  @override
  Future<ApiResponse<Fragment$taxiSupportRequestActivity>> updateStatus({
    required Input$ChangeTaxiSupportRequestStatusInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockTaxiSupportRequestActivity1);
  }
}
