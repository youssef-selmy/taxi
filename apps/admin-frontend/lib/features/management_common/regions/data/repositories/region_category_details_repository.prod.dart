import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/region.graphql.dart';
import 'package:admin_frontend/features/management_common/regions/data/graphql/region_category_details.graphql.dart';
import 'package:admin_frontend/features/management_common/regions/data/repositories/region_category_details_repository.dart';

@prod
@LazySingleton(as: RegionCategoryDetailsRepository)
class RegionCategoryDetailsRepositoryImpl
    implements RegionCategoryDetailsRepository {
  final GraphqlDatasource graphQLDatasource;

  RegionCategoryDetailsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$regionCategory>> createRegionCategory({
    required String name,
    required String currency,
  }) async {
    final regionCategory = await graphQLDatasource.mutate(
      Options$Mutation$createRegionCategory(
        variables: Variables$Mutation$createRegionCategory(
          name: name,
          currency: currency,
        ),
      ),
    );
    return regionCategory.mapData((r) => r.createOneRegionCategory);
  }

  @override
  Future<ApiResponse<String>> deleteRegionCategory(String id) async {
    final regionCategory = await graphQLDatasource.mutate(
      Options$Mutation$deleteRegionCategory(
        variables: Variables$Mutation$deleteRegionCategory(id: id),
      ),
    );
    return regionCategory.mapData((r) => r.deleteOneRegionCategory.id ?? "0");
  }

  @override
  Future<ApiResponse<Fragment$regionCategory>> updateRegionCategory({
    required String id,
    required String name,
    required String currency,
  }) async {
    final regionCategory = await graphQLDatasource.mutate(
      Options$Mutation$updateRegionCategory(
        variables: Variables$Mutation$updateRegionCategory(
          id: id,
          name: name,
          currency: currency,
        ),
      ),
    );
    return regionCategory.mapData((r) => r.updateOneRegionCategory);
  }

  @override
  Future<ApiResponse<Fragment$regionCategory>> getRegionCategory({
    required String regionCategoryId,
  }) async {
    final regionCategory = await graphQLDatasource.query(
      Options$Query$regionCategory(
        variables: Variables$Query$regionCategory(id: regionCategoryId),
      ),
    );
    return regionCategory.mapData((r) => r.regionCategory);
  }
}
