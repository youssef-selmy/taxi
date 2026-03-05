import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_reviews/data/graphql/driver_detail_reviews.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class DriverDetailReviewsRepository {
  Future<ApiResponse<Query$driverReviews>> getDriverReviews({
    required String driverId,
    required Input$OffsetPaging? paging,
  });
}
