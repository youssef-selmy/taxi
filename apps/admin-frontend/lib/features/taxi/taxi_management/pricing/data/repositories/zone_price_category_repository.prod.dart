import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/zone_price.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/graphql/zone_price_category.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/zone_price_category_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ZonePriceCategoryRepository)
class ZonePriceCategoryRepositoryImpl implements ZonePriceCategoryRepository {
  final GraphqlDatasource graphQLDatasource;

  ZonePriceCategoryRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$zonePriceCategory>> create({
    required String name,
  }) async {
    final zonePriceCategory = await graphQLDatasource.mutate(
      Options$Mutation$createZonePriceCategory(
        variables: Variables$Mutation$createZonePriceCategory(
          input: Input$ZonePriceCategoryInput(name: name),
        ),
      ),
    );
    return zonePriceCategory.mapData((r) => r.createOneZonePriceCategory);
  }

  @override
  Future<ApiResponse<String>> delete(String id) async {
    final zonePriceCategory = await graphQLDatasource.mutate(
      Options$Mutation$deleteZonePriceCategory(
        variables: Variables$Mutation$deleteZonePriceCategory(id: id),
      ),
    );
    return zonePriceCategory.mapData(
      (r) => r.deleteOneZonePriceCategory.id ?? "0",
    );
  }

  @override
  Future<ApiResponse<List<Fragment$zonePriceCategory>>> getAll() async {
    final zonePriceCategories = await graphQLDatasource.query(
      Options$Query$zonePriceCategories(),
    );
    return zonePriceCategories.mapData((r) => r.zonePriceCategories);
  }

  @override
  Future<ApiResponse<Fragment$zonePriceCategory>> getOne({
    required String id,
  }) async {
    final zonePriceCategory = await graphQLDatasource.query(
      Options$Query$zonePriceCategory(
        variables: Variables$Query$zonePriceCategory(id: id),
      ),
    );
    return zonePriceCategory.mapData((r) => r.zonePriceCategory);
  }

  @override
  Future<ApiResponse<Fragment$zonePriceCategory>> update({
    required String id,
    required String name,
  }) async {
    final zonePriceCategory = await graphQLDatasource.mutate(
      Options$Mutation$updateZonePriceCategory(
        variables: Variables$Mutation$updateZonePriceCategory(
          id: id,
          input: Input$ZonePriceCategoryInput(name: name),
        ),
      ),
    );
    return zonePriceCategory.mapData((r) => r.updateOneZonePriceCategory);
  }
}
