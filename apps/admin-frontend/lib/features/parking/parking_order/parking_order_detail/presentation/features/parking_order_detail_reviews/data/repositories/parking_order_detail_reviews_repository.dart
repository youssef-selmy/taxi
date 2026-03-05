import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_reviews/data/graphql/parking_order_detail_reviews.graphql.dart';

abstract class ParkingOrderDetailReviewsRepository {
  Future<ApiResponse<Query$getParkingOrderReview>> getParkingOrderDetailReview({
    required String parkingOrderId,
  });
}
