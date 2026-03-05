import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/graphql/customer_complaints_shop.graphql.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/customer_complaints_shop_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: CustomerComplaintsShopRepository)
class CustomerComplaintsShopRepositoryImpl
    implements CustomerComplaintsShopRepository {
  final GraphqlDatasource graphQLDatasource;

  CustomerComplaintsShopRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$customerComplaintsShop>> getCustomerComplaintsShop({
    required Input$OffsetPaging? paging,
    required Input$ShopSupportRequestFilter filter,
    required List<Input$ShopSupportRequestSort> sorting,
  }) async {
    final supportRequestsResponse = await graphQLDatasource.query(
      Options$Query$customerComplaintsShop(
        variables: Variables$Query$customerComplaintsShop(
          filter: filter,
          paging: paging,
          sorting: sorting,
        ),
      ),
    );
    return supportRequestsResponse;
  }
}
