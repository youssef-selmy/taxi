import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_support_request.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_list/data/graphql/taxi_support_request.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_list/data/repositories/taxi_support_request_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: TaxiSupportRequestRepository)
class TaxiSupportRequestRepositoryMock implements TaxiSupportRequestRepository {
  @override
  Future<ApiResponse<Query$taxiSupportRequests>> getAll({
    required Input$OffsetPaging? paging,
    required Input$TaxiSupportRequestFilter filter,
    required List<Input$TaxiSupportRequestSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$taxiSupportRequests(
        taxiSupportRequests: Query$taxiSupportRequests$taxiSupportRequests(
          pageInfo: mockPageInfo,
          totalCount: mockTaxiSupportRequests.length,
          nodes: mockTaxiSupportRequests,
        ),
      ),
    );
  }
}
