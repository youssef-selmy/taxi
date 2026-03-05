import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/shop.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopDetailRepository)
class ShopDetailRepositoryImpl implements ShopDetailRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopDetailRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$shopDetail>> getShopDetail({
    required String shopId,
  }) async {
    final shopOrError = await graphQLDatasource.query(
      Options$Query$shopDetail(
        variables: Variables$Query$shopDetail(id: shopId),
      ),
    );
    return shopOrError.mapData((r) => r.shop);
  }

  @override
  Future<ApiResponse<Fragment$shopDetail>> updateShop({
    required String shopId,
    required Input$UpsertShopInput input,
  }) async {
    final shopOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateShop(
        variables: Variables$Mutation$updateShop(id: shopId, update: input),
      ),
    );
    return shopOrError.mapData((r) => r.updateOneShop);
  }
}
