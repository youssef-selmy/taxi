import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item_category.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_items_and_categories.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_categories_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopDetailCategoriesRepository)
class ShopDetailCategoriesRepositoryImpl
    implements ShopDetailCategoriesRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopDetailCategoriesRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$shopItemCategories>> getShopItemCategories({
    required Input$ItemCategoryFilter filter,
    required List<Input$ItemCategorySort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    final categoriesOrError = await graphQLDatasource.query(
      Options$Query$shopItemCategories(
        variables: Variables$Query$shopItemCategories(
          filter: filter,
          paging: paging,
          sorting: sorting,
        ),
      ),
    );
    return categoriesOrError;
  }

  @override
  Future<ApiResponse<void>> deleteShopItemCategory({required String id}) async {
    final deleteOrError = await graphQLDatasource.mutate(
      Options$Mutation$deleteItemCategory(
        variables: Variables$Mutation$deleteItemCategory(id: id),
      ),
    );
    return deleteOrError;
  }

  @override
  Future<ApiResponse<Fragment$shopItemCategoryDetail>> getShopItemCategory({
    required String id,
  }) async {
    final categoryOrError = await graphQLDatasource.query(
      Options$Query$itemCategory(
        variables: Variables$Query$itemCategory(id: id),
      ),
    );
    return categoryOrError.mapData((r) => r.itemCategory);
  }

  @override
  Future<ApiResponse<void>> createShopItemCategory({
    required Input$CreateItemCategoryInput input,
  }) async {
    final createOrError = await graphQLDatasource.mutate(
      Options$Mutation$createShopItemCategory(
        variables: Variables$Mutation$createShopItemCategory(input: input),
      ),
    );
    return createOrError;
  }

  @override
  Future<ApiResponse<void>> updateShopItemCategory({
    required String id,
    required Input$UpdateItemCategoryInput input,
  }) async {
    final updateOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateShopItemCategory(
        variables: Variables$Mutation$updateShopItemCategory(
          id: id,
          update: input,
        ),
      ),
    );
    return updateOrError;
  }
}
