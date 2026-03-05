import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/review_taxi.graphql.mock.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/reviews_taxi.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/reviews_taxi_repository.dart';

@dev
@LazySingleton(as: ReviewsTaxiRepository)
class ReviewsTaxiRepositoryMock implements ReviewsTaxiRepository {
  @override
  Future<ApiResponse<Query$customerTaxiReviews>> getCustomerTaxiReviews(
    String customerId,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$customerTaxiReviews(
        taxiReviews: Query$customerTaxiReviews$taxiReviews(
          nodes: mockReviewsTaxi,
          pageInfo: mockPageInfo,
          totalCount: mockReviewsTaxi.length,
        ),
      ),
    );
  }
}
