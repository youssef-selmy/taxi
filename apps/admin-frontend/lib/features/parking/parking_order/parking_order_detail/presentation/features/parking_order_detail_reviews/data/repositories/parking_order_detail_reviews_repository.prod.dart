import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_reviews/data/graphql/parking_order_detail_reviews.graphql.dart';
import 'package:admin_frontend/features/parking/parking_order/parking_order_detail/presentation/features/parking_order_detail_reviews/data/repositories/parking_order_detail_reviews_repository.dart';

@prod
@LazySingleton(as: ParkingOrderDetailReviewsRepository)
class ParkingOrderDetailReviewsRepositoryImpl
    implements ParkingOrderDetailReviewsRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkingOrderDetailReviewsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$getParkingOrderReview>> getParkingOrderDetailReview({
    required String parkingOrderId,
  }) async {
    final getParkingOrderDetailReview = await graphQLDatasource.query(
      Options$Query$getParkingOrderReview(
        variables: Variables$Query$getParkingOrderReview(
          parkingId: parkingOrderId,
        ),
      ),
    );
    return getParkingOrderDetailReview;
  }
}
