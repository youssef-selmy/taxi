import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_support_request.graphql.mock.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/customer_complaints_taxi.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/customer_complaints_taxi_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: CustomerComplaintsTaxiRepository)
class CustomerComplaintsTaxiRepositoryMock
    implements CustomerComplaintsTaxiRepository {
  @override
  Future<ApiResponse<Query$customerComplaintsTaxi>> getCustomerComplaintsTaxi({
    required Input$OffsetPaging? paging,
    required Input$TaxiSupportRequestFilter filter,
    required List<Input$TaxiSupportRequestSort> sorting,
  }) async {
    return ApiResponse.loaded(
      Query$customerComplaintsTaxi(
        taxiSupportRequests: Query$customerComplaintsTaxi$taxiSupportRequests(
          nodes: mockTaxiSupportRequests,
          pageInfo: mockPageInfo,
          totalCount: mockTaxiSupportRequests.length,
        ),
      ),
    );
  }
}
