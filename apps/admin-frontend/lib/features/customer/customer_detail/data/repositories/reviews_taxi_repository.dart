import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/customer/customer_detail/data/graphql/reviews_taxi.graphql.dart';

abstract class ReviewsTaxiRepository {
  Future<ApiResponse<Query$customerTaxiReviews>> getCustomerTaxiReviews(
    String customerId,
  );
}
