import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_category.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_create/data/graphql/vendor_create.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_create/data/repositories/vendor_create_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: VendorCreateRepository)
class VendorCreateRepositoryImpl implements VendorCreateRepository {
  final GraphqlDatasource graphQLDatasource;

  VendorCreateRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$shopDetail>> createShop({
    required Input$UpsertShopInput input,
    required List<String> categoryIds,
  }) async {
    final shopDetailOrError = await graphQLDatasource.mutate(
      Options$Mutation$createShop(
        variables: Variables$Mutation$createShop(input: input),
      ),
    );
    if (shopDetailOrError.isError) {
      return shopDetailOrError.mapData((r) => r.createOneShop);
    }
    final setCategoriesOrError = await graphQLDatasource.mutate(
      Options$Mutation$setCategoriesOnShop(
        variables: Variables$Mutation$setCategoriesOnShop(
          shopId: shopDetailOrError.data!.createOneShop.id,
          categoryIds: categoryIds,
        ),
      ),
    );
    return setCategoriesOrError.mapData((r) => r.setCategoriesOnShop);
  }

  @override
  Future<ApiResponse<Fragment$shopDetail>> getShopDetail({
    required String id,
  }) async {
    final shopDetailOrError = await graphQLDatasource.query(
      Options$Query$shop(variables: Variables$Query$shop(id: id)),
    );
    return shopDetailOrError.mapData((r) => r.shop);
  }

  @override
  Future<ApiResponse<Fragment$shopDetail>> updateShop({
    required String id,
    required Input$UpsertShopInput input,
    required List<String> categoryIds,
  }) async {
    final shopDetailOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateShop(
        variables: Variables$Mutation$updateShop(id: id, update: input),
      ),
    );
    if (shopDetailOrError.isError) {
      return shopDetailOrError.mapData((r) => r.updateOneShop);
    }
    final setCategoriesOrError = await graphQLDatasource.mutate(
      Options$Mutation$setCategoriesOnShop(
        variables: Variables$Mutation$setCategoriesOnShop(
          shopId: id,
          categoryIds: categoryIds,
        ),
      ),
    );
    return setCategoriesOrError.mapData((r) => r.setCategoriesOnShop);
  }

  @override
  Future<ApiResponse<List<Fragment$shopCategoryCompact>>>
  getShopCategories() async {
    final shopCategoriesOrError = await graphQLDatasource.query(
      Options$Query$shopCategories(),
    );
    return shopCategoriesOrError.mapData((r) => r.shopCategories.nodes);
  }
}
