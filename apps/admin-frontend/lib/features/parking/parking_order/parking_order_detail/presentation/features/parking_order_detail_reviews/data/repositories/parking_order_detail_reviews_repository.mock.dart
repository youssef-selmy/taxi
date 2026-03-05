import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_reviews/data/graphql/parking_order_detail_reviews.graphql.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_reviews/data/repositories/parking_order_detail_reviews_repository.dart';

@dev
@LazySingleton(as: ParkingOrderDetailReviewsRepository)
class ParkingOrderDetailReviewsRepositoryMock
    implements ParkingOrderDetailReviewsRepository {
  @override
  Future<ApiResponse<Query$getParkingOrderReview>> getParkingOrderDetailReview({
    required String parkingOrderId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$getParkingOrderReview(
        parkOrder: Query$getParkingOrderReview$parkOrder(
          feedbacks: mockParkingFeedbacks,
        ),
      ),
    );
  }
}
