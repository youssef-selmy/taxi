import 'package:api_response/api_response.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/shop/shop_management/shop_categories/shop_category_list/data/graphql/shop_category_list.graphql.dart';
import 'package:admin_frontend/features/shop/shop_management/shop_categories/shop_category_list/data/repositories/shop_category_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopCategoryListRepository)
class ShopCategoryListRepositoryImpl implements ShopCategoryListRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopCategoryListRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$shopCategories>> getShopCategories({
    required Input$OffsetPaging? paging,
    required List<Input$ShopCategorySort> sorting,
    required Input$ShopCategoryFilter filter,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$shopCategories(
        fetchPolicy: FetchPolicy.networkOnly,
        variables: Variables$Query$shopCategories(
          paging: paging,
          sorting: sorting,
          filter: filter,
        ),
      ),
    );
    return result;
  }
}
