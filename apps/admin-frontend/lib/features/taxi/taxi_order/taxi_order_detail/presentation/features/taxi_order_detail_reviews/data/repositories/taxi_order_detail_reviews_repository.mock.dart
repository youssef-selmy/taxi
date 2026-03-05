import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/review_taxi.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_reviews/data/graphql/taxi_order_detail_reviews.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_reviews/data/repositories/taxi_order_detail_reviews_repository.dart';

@dev
@LazySingleton(as: TaxiOrderDetailReviewsRepository)
class TaxiOrderDetailReviewsRepositoryMock
    implements TaxiOrderDetailReviewsRepository {
  @override
  Future<ApiResponse<Query$taxiOrderDetailReviews>> getTaxiOrderDetailReviews({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$taxiOrderDetailReviews(
        taxiOrderReviews: Query$taxiOrderDetailReviews$taxiOrderReviews(
          nodes: mockReviewsTaxi,
        ),
      ),
    );
  }
}
