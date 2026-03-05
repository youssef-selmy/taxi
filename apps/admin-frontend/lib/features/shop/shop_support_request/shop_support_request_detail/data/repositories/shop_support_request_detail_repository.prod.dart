import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_support_request.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/shop_support_request/shop_support_request_detail/data/graphql/shop_support_request_detail.graphql.dart';
import 'package:admin_frontend/features/shop/shop_support_request/shop_support_request_detail/data/repositories/shop_support_request_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopSupportRequestDetailRepository)
class ShopSupportRequestDetailRepositoryImpl
    implements ShopSupportRequestDetailRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopSupportRequestDetailRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$shopSupportRequest>> getSupportRequest({
    required String id,
  }) async {
    final supportRequestOrError = await graphQLDatasource.query(
      Options$Query$shopSupportRequest(
        variables: Variables$Query$shopSupportRequest(id: id),
      ),
    );
    return supportRequestOrError;
  }

  @override
  Future<ApiResponse<Fragment$shopSupportRequestActivity>> addComment({
    required Input$CreateShopSupportRequestCommentInput input,
  }) async {
    final addCommentSupport = await graphQLDatasource.mutate(
      Options$Mutation$addCommentToShopSupportRequest(
        variables: Variables$Mutation$addCommentToShopSupportRequest(
          input: input,
        ),
      ),
    );
    return addCommentSupport.mapData((f) => f.addCommentToShopSupportRequest);
  }

  @override
  Future<ApiResponse<Fragment$shopSupportRequestActivity>> assignToStaffs({
    required Input$AssignShopSupportRequestInput input,
  }) async {
    final assignSupportRequest = await graphQLDatasource.mutate(
      Options$Mutation$assignStaffsToShopSupportRequest(
        variables: Variables$Mutation$assignStaffsToShopSupportRequest(
          input: input,
        ),
      ),
    );
    return assignSupportRequest.mapData(
      (f) => f.assignShopSupportRequestToStaff,
    );
  }

  @override
  Future<ApiResponse<Fragment$shopSupportRequestActivity>> updateStatus({
    required Input$ChangeShopSupportRequestStatusInput input,
  }) async {
    final changeSupportRequest = await graphQLDatasource.mutate(
      Options$Mutation$updateShopSupportRequestStatus(
        variables: Variables$Mutation$updateShopSupportRequestStatus(
          input: input,
        ),
      ),
    );
    return changeSupportRequest.mapData(
      (f) => f.changeShopSupportRequestStatus,
    );
  }
}
