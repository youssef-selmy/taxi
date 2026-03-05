import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_reviews/data/graphql/driver_detail_reviews.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_reviews/data/repositories/driver_detail_reviews_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: DriverDetailReviewsRepository)
class DriverDetailReviewsRepositoryImpl
    implements DriverDetailReviewsRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverDetailReviewsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$driverReviews>> getDriverReviews({
    required String driverId,
    required Input$OffsetPaging? paging,
  }) async {
    var getDriverReviewsOrError = graphQLDatasource.query(
      Options$Query$driverReviews(
        variables: Variables$Query$driverReviews(id: driverId),
      ),
    );
    return getDriverReviewsOrError;
  }
}
