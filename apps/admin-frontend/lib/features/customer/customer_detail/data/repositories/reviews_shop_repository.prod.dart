import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/reviews_shop.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/reviews_shop_repository.dart';

@prod
@LazySingleton(as: ReviewsShopRepository)
class ReviewsShopRepositoryImpl implements ReviewsShopRepository {
  final GraphqlDatasource graphQLDatasource;

  ReviewsShopRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$customerShopReviews>> getCustomerShopReviews(
    String customerId,
  ) async {
    final reviews = await graphQLDatasource.query(
      Options$Query$customerShopReviews(
        variables: Variables$Query$customerShopReviews(customerId: customerId),
      ),
    );
    return reviews;
  }
}
