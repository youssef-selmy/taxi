import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/review_taxi.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_reviews/data/graphql/driver_detail_reviews.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_reviews/data/repositories/driver_detail_reviews_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: DriverDetailReviewsRepository)
class DriverDetailReviewsRepositoryMock
    implements DriverDetailReviewsRepository {
  @override
  Future<ApiResponse<Query$driverReviews>> getDriverReviews({
    required String driverId,
    required Input$OffsetPaging? paging,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return ApiResponse.loaded(
      Query$driverReviews(
        reviews: Query$driverReviews$reviews(
          totalCount: 12,
          nodes: mockReviewsTaxi,
          pageInfo: mockPageInfo,
        ),
      ),
    );
  }
}
