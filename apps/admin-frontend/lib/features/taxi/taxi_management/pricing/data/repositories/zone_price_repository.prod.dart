import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/zone_price.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/graphql/zone_price.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/zone_price_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ZonePriceRepository)
class ZonePriceRepositoryImpl implements ZonePriceRepository {
  final GraphqlDatasource graphQLDatasource;

  ZonePriceRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$zonePrice>> create({
    required Input$ZonePriceInput input,
    required List<String> fleetIds,
    required List<String> serviceIds,
  }) async {
    final zonePrice = await graphQLDatasource.mutate(
      Options$Mutation$createZonePrice(
        variables: Variables$Mutation$createZonePrice(input: input),
      ),
    );
    final createdZonePriceId = zonePrice.mapData(
      (r) => r.createOneZonePrice.id,
    );
    if (createdZonePriceId.data == null) {
      return ApiResponse.error("Failed to create zone price");
    }

    final assignServiceIdsAndFleetIds = await graphQLDatasource.mutate(
      Options$Mutation$assignServiceAndFleetIds(
        variables: Variables$Mutation$assignServiceAndFleetIds(
          zonePriceId: createdZonePriceId.data!,
          fleetIds: fleetIds,
          serviceIds: serviceIds,
        ),
      ),
    );
    return assignServiceIdsAndFleetIds.mapData((r) => r.setFleetsOnZonePrice);
  }

  @override
  Future<ApiResponse<String>> delete(String id) async {
    final zonePrice = await graphQLDatasource.mutate(
      Options$Mutation$deleteZonePrice(
        variables: Variables$Mutation$deleteZonePrice(id: id),
      ),
    );
    return zonePrice.mapData((r) => r.deleteOneZonePrice.id ?? "0");
  }

  @override
  Future<ApiResponse<Query$zonePrices>> getAll({
    required String? categoryId,
    required String? search,
  }) async {
    final zonePrices = await graphQLDatasource.query(
      Options$Query$zonePrices(),
    );
    return zonePrices;
  }

  @override
  Future<ApiResponse<Query$zonePrice>> getOne({required String id}) async {
    final zonePrice = await graphQLDatasource.query(
      Options$Query$zonePrice(variables: Variables$Query$zonePrice(id: id)),
    );
    return zonePrice;
  }

  @override
  Future<ApiResponse<Fragment$zonePrice>> update({
    required String id,
    required Input$ZonePriceInput input,
    required List<String> fleetIds,
    required List<String> serviceIds,
  }) async {
    final zonePrice = await graphQLDatasource.mutate(
      Options$Mutation$updateZonePrice(
        variables: Variables$Mutation$updateZonePrice(
          id: id,
          input: input,
          fleetIds: fleetIds,
          serviceIds: serviceIds,
        ),
      ),
    );
    return zonePrice.mapData((r) => r.updateOneZonePrice);
  }

  @override
  Future<ApiResponse<Query$zonePriceFieldOptions>> getFieldOptions() async {
    final fieldOptionsResponse = await graphQLDatasource.query(
      Options$Query$zonePriceFieldOptions(),
    );
    return fieldOptionsResponse;
  }
}
