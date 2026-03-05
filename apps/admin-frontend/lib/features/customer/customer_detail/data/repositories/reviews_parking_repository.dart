import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/customer/customer_detail/data/graphql/reviews_parking.graphql.dart';

abstract class ReviewsParkingRepository {
  Future<ApiResponse<Query$customerParkingReviews>> getCustomerParkingReviews(
    String customerId,
  );
}
