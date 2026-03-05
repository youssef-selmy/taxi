import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/region.graphql.dart';
import 'package:admin_frontend/features/management_common/regions/data/graphql/region_details.graphql.dart';
import 'package:admin_frontend/features/management_common/regions/data/repositories/region_details_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: RegionDetailsRepository)
class RegionDetailsRepositoryImpl implements RegionDetailsRepository {
  final GraphqlDatasource graphQLDatasource;

  RegionDetailsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$region>> createRegion({
    required Input$CreateRegionInput input,
  }) async {
    final region = await graphQLDatasource.mutate(
      Options$Mutation$createRegion(
        variables: Variables$Mutation$createRegion(input: input),
      ),
    );
    return region.mapData((r) => r.createOneRegion);
  }

  @override
  Future<ApiResponse<Fragment$region>> updateRegion({
    required String id,
    required Input$UpdateRegionInput input,
  }) async {
    final region = await graphQLDatasource.mutate(
      Options$Mutation$updateRegion(
        variables: Variables$Mutation$updateRegion(id: id, input: input),
      ),
    );
    return region.mapData((r) => r.updateOneRegion);
  }

  @override
  Future<ApiResponse<Fragment$region>> getRegion({
    required String regionId,
  }) async {
    final region = await graphQLDatasource.query(
      Options$Query$region(variables: Variables$Query$region(id: regionId)),
    );
    return region.mapData((r) => r.region);
  }

  @override
  Future<ApiResponse<String>> deleteRegion(String id) async {
    final region = await graphQLDatasource.mutate(
      Options$Mutation$deleteRegion(
        variables: Variables$Mutation$deleteRegion(id: id),
      ),
    );
    return region.mapData((r) => r.deleteOneRegion.id ?? "0");
  }
}
