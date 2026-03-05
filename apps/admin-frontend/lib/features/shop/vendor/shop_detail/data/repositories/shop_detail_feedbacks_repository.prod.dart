import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_feedbacks.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_feedbacks_repository.dart';

@prod
@LazySingleton(as: ShopDetailFeedbacksRepository)
class ShopDetailFeedbacksRepositoryImpl
    implements ShopDetailFeedbacksRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopDetailFeedbacksRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$shopFeedbacks>> getFeedbacks({
    required String shopId,
  }) async {
    final feedbacksOrError = await graphQLDatasource.query(
      Options$Query$shopFeedbacks(
        variables: Variables$Query$shopFeedbacks(shopId: shopId),
      ),
    );
    return feedbacksOrError;
  }
}
