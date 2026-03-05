import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_reviews/data/graphql/taxi_order_detail_reviews.graphql.dart';

abstract class TaxiOrderDetailReviewsRepository {
  Future<ApiResponse<Query$taxiOrderDetailReviews>> getTaxiOrderDetailReviews({
    required String id,
  });
}
