import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/shop/shop_support_request/shop_support_request_list/data/graphql/shop_support_request.graphql.dart';
import 'package:admin_frontend/features/shop/shop_support_request/shop_support_request_list/data/repositories/shop_support_request_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopSupportRequestRepository)
class ShopSupportRequestRepositoryImpl implements ShopSupportRequestRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopSupportRequestRepositoryImpl(this.graphQLDatasource);
  @override
  Future<ApiResponse<Query$shopSupportRequests>> getAll({
    required Input$OffsetPaging? paging,
    required Input$ShopSupportRequestFilter filter,
    required List<Input$ShopSupportRequestSort> sorting,
  }) async {
    final getAllSupportRequest = await graphQLDatasource.query(
      Options$Query$shopSupportRequests(
        variables: Variables$Query$shopSupportRequests(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return getAllSupportRequest;
  }
}
