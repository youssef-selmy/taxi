import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_item.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_items_and_categories.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_items_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopDetailItemsRepository)
class ShopDetailItemsRepositoryImpl implements ShopDetailItemsRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopDetailItemsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$shopItems>> getShopItems({
    required Input$ItemFilter filter,
    required List<Input$ItemSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    final itemsOrError = await graphQLDatasource.query(
      Options$Query$shopItems(
        variables: Variables$Query$shopItems(
          filter: filter,
          paging: paging,
          sorting: sorting,
        ),
      ),
    );
    return itemsOrError;
  }

  @override
  Future<ApiResponse<void>> deleteShopItem({required String itemId}) async {
    final deleteOrError = await graphQLDatasource.mutate(
      Options$Mutation$deleteShopItem(
        variables: Variables$Mutation$deleteShopItem(id: itemId),
      ),
    );
    return deleteOrError;
  }

  @override
  Future<ApiResponse<Fragment$shopItemListItem>> getShopItem({
    required String itemId,
  }) async {
    final itemOrError = await graphQLDatasource.query(
      Options$Query$shopItem(variables: Variables$Query$shopItem(id: itemId)),
    );
    return itemOrError.mapData((data) => data.item);
  }
}
