import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_reviews/data/graphql/shop_order_detail_reviews.graphql.dart';
import 'package:admin_frontend/features/shop/shop_order/shop_order_detail/presentation/features/shop_order_detail_reviews/data/repositories/shop_order_detail_reviews_repository.dart';

@prod
@LazySingleton(as: ShopOrderDetailReviewsRepository)
class ShopOrderDetailReviewsRepositoryImpl
    implements ShopOrderDetailReviewsRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopOrderDetailReviewsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$shopOrderReviews>> getFeedBacks({
    required String orderId,
  }) async {
    final getShopOrderDetailReview = await graphQLDatasource.query(
      Options$Query$shopOrderReviews(
        variables: Variables$Query$shopOrderReviews(orderId: orderId),
      ),
    );
    return getShopOrderDetailReview;
  }
}
