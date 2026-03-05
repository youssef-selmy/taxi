import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_delivery_region.fragment.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/graphql/shop_detail_delivery.graphql.dart';
import 'package:admin_frontend/features/shop/vendor/shop_detail/data/repositories/shop_detail_delivery_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ShopDetailDeliveryRepository)
class ShopDetailDeliveryRepositoryImpl implements ShopDetailDeliveryRepository {
  final GraphqlDatasource graphQLDatasource;

  ShopDetailDeliveryRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<void>> createShopDeliveryRegion({
    required Input$CreateShopDeliveryZoneInput input,
  }) async {
    final createOrError = await graphQLDatasource.mutate(
      Options$Mutation$createShopDeliveryZone(
        variables: Variables$Mutation$createShopDeliveryZone(input: input),
      ),
    );
    return createOrError.mapData((r) => r.createOneShopDeliveryZone);
  }

  @override
  Future<ApiResponse<void>> deleteShopDeliveryRegion({
    required String regionId,
  }) async {
    final deleteOrError = await graphQLDatasource.mutate(
      Options$Mutation$deleteShopDeliveryZone(
        variables: Variables$Mutation$deleteShopDeliveryZone(id: regionId),
      ),
    );
    return deleteOrError.mapData((r) => r.deleteOneShopDeliveryZone);
  }

  @override
  Future<ApiResponse<Fragment$shopDeliveryRegion>> getShopDeliveryRegion({
    required String regionId,
  }) async {
    final deliveryZoneOrError = await graphQLDatasource.query(
      Options$Query$shopDeliveryZone(
        variables: Variables$Query$shopDeliveryZone(id: regionId),
      ),
    );
    return deliveryZoneOrError.mapData((r) => r.shopDeliveryRegion);
  }

  @override
  Future<ApiResponse<Query$shopDeliveryZones>> getShopDeliveryRegions({
    required Input$ShopDeliveryZoneFilter filter,
    required List<Input$ShopDeliveryZoneSort> sorting,
    required Input$OffsetPaging? paging,
  }) async {
    final deliveryZonesOrError = await graphQLDatasource.query(
      Options$Query$shopDeliveryZones(
        variables: Variables$Query$shopDeliveryZones(
          filter: filter,
          sorting: sorting,
          paging: paging,
        ),
      ),
    );
    return deliveryZonesOrError;
  }

  @override
  Future<ApiResponse<void>> updateShopDeliveryRegion({
    required String regionId,
    required Input$UpdateShopDeliveryZoneInput input,
  }) async {
    final updateOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateShopDeliveryZone(
        variables: Variables$Mutation$updateShopDeliveryZone(
          id: regionId,
          update: input,
        ),
      ),
    );
    return updateOrError.mapData((r) => r.updateOneShopDeliveryZone);
  }
}
