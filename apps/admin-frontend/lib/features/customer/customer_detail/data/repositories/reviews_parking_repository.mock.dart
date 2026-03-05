import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.mock.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/reviews_parking.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/reviews_parking_repository.dart';

@dev
@LazySingleton(as: ReviewsParkingRepository)
class ReviewsParkingRepositoryMock implements ReviewsParkingRepository {
  @override
  Future<ApiResponse<Query$customerParkingReviews>> getCustomerParkingReviews(
    String customerId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$customerParkingReviews(
        parkingFeedbacks: Query$customerParkingReviews$parkingFeedbacks(
          nodes: mockParkingFeedbacks,
          pageInfo: mockPageInfo,
          totalCount: mockParkingFeedbacks.length,
        ),
      ),
    );
  }
}
