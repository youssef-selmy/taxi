import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_feedback.graphql.dart';
import 'package:admin_frontend/features/shop/shop_review/shop_review_list/data/graphql/shop_review_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_review/shop_review_list/data/repositories/shop_review_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopReviewListRepository)
class ShopReviewListRepositoryImpl implements ShopReviewListRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopReviewListRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$shopFeedbacks>> getShopReviewsList({
    required Input$OffsetPaging? paging,
    required Input$ShopFeedbackFilter filter,
    required List<Input$ShopFeedbackSort> sorting,
  }) async {
    final getShopReviewsList = await graphQLDatasource.query(
      Options$Query$shopFeedbacks(
        variables: Variables$Query$shopFeedbacks(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return getShopReviewsList;
  }

  @override
  Future<ApiResponse<Fragment$shopFeedback>> updateShopFeedbackStatus({
    required String id,
    required Enum$ReviewStatus status,
  }) async {
    final updateOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateShopFeedbackStatus(
        variables: Variables$Mutation$updateShopFeedbackStatus(
          feedbackId: id,
          status: status,
        ),
      ),
    );
    return updateOrError.mapData((f) => f.updateShopFeedbackStatus);
  }
}
