import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/reviews_taxi.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/reviews_taxi_repository.dart';

@prod
@LazySingleton(as: ReviewsTaxiRepository)
class ReviewsTaxiRepositoryImpl implements ReviewsTaxiRepository {
  final GraphqlDatasource graphQLDatasource;

  ReviewsTaxiRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$customerTaxiReviews>> getCustomerTaxiReviews(
    String customerId,
  ) async {
    final reviews = await graphQLDatasource.query(
      Options$Query$customerTaxiReviews(
        variables: Variables$Query$customerTaxiReviews(customerId: customerId),
      ),
    );
    return reviews;
  }
}
