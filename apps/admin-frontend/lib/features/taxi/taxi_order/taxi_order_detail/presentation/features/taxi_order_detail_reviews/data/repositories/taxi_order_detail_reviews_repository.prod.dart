import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_reviews/data/graphql/taxi_order_detail_reviews.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_order/taxi_order_detail/presentation/features/taxi_order_detail_reviews/data/repositories/taxi_order_detail_reviews_repository.dart';

@prod
@LazySingleton(as: TaxiOrderDetailReviewsRepository)
class TaxiOrderDetailReviewsRepositoryImpl
    implements TaxiOrderDetailReviewsRepository {
  final GraphqlDatasource graphQLDatasource;

  TaxiOrderDetailReviewsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$taxiOrderDetailReviews>> getTaxiOrderDetailReviews({
    required String id,
  }) async {
    final getTaxiOrderDetailReviews = await graphQLDatasource.query(
      Options$Query$taxiOrderDetailReviews(
        variables: Variables$Query$taxiOrderDetailReviews(orderId: id),
      ),
    );
    return getTaxiOrderDetailReviews;
  }
}
