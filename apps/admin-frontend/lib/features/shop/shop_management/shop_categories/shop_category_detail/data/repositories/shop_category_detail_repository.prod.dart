import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.dart';
import 'package:admin_frontend/features/shop/shop_management/shop_categories/shop_category_detail/data/graphql/shop_category_detail.graphql.dart';
import 'package:admin_frontend/features/shop/shop_management/shop_categories/shop_category_detail/data/repositories/shop_category_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopCategoryDetailRepository)
class ShopCategoryDetailRepositoryImpl implements ShopCategoryDetailRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopCategoryDetailRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$shopCategory>> createShopCategory({
    required Input$CreateShopCategoryInput input,
  }) async {
    final shopCategoryOrError = await graphQLDatasource.mutate(
      Options$Mutation$createShopCategory(
        variables: Variables$Mutation$createShopCategory(input: input),
      ),
    );
    return shopCategoryOrError.mapData((r) => r.createOneShopCategory);
  }

  @override
  Future<ApiResponse<void>> deleteShopCategory(String id) async {
    final shopCategoryOrError = await graphQLDatasource.mutate(
      Options$Mutation$deleteShopCategory(
        variables: Variables$Mutation$deleteShopCategory(id: id),
      ),
    );
    return shopCategoryOrError.mapData((r) => r.deleteOneShopCategory);
  }

  @override
  Future<ApiResponse<Fragment$shopCategory>> getShopCategory(String id) async {
    final shopCategoryOrError = await graphQLDatasource.query(
      Options$Query$shopCategory(
        variables: Variables$Query$shopCategory(id: id),
      ),
    );
    return shopCategoryOrError.mapData((r) => r.shopCategory);
  }

  @override
  Future<ApiResponse<Fragment$shopCategory>> updateShopCategory({
    required String id,
    required Input$UpdateShopCategoryInput input,
  }) async {
    final shopCategoryOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateShopCategory(
        variables: Variables$Mutation$updateShopCategory(id: id, input: input),
      ),
    );
    return shopCategoryOrError.mapData((r) => r.updateOneShopCategory);
  }
}
