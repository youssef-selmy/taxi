import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/taxi_support_request.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_complaints/data/graphql/taxi_order_detail_complaints.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_complaints/data/repositories/taxi_order_detail_complaints_repository.dart';

@dev
@LazySingleton(as: TaxiOrderDetailComplaintsRepository)
class TaxiOrderDetailComplaintsRepositoryMock
    implements TaxiOrderDetailComplaintsRepository {
  @override
  Future<ApiResponse<Query$taxiOrderSupportRequests>> getTaxiOrderComplaints({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$taxiOrderSupportRequests(
        taxiOrderSupportRequests:
            Query$taxiOrderSupportRequests$taxiOrderSupportRequests(
              nodes: mockTaxiSupportRequests,
            ),
      ),
    );
  }
}
