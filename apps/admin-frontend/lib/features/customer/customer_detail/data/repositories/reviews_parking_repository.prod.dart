import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/reviews_parking.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/reviews_parking_repository.dart';

@prod
@LazySingleton(as: ReviewsParkingRepository)
class ReviewsParkingRepositoryImpl implements ReviewsParkingRepository {
  final GraphqlDatasource graphQLDatasource;

  ReviewsParkingRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$customerParkingReviews>> getCustomerParkingReviews(
    String customerId,
  ) async {
    final reviews = await graphQLDatasource.query(
      Options$Query$customerParkingReviews(
        variables: Variables$Query$customerParkingReviews(
          customerId: customerId,
        ),
      ),
    );
    return reviews;
  }
}
