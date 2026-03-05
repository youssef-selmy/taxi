import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/graphql/pricing_category.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/pricing_category_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: PricingCategoryRepository)
class PricingCategoryRepositoryImpl implements PricingCategoryRepository {
  final GraphqlDatasource graphQLDatasource;

  PricingCategoryRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$taxiPricingCategory>> create({
    required String name,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$createTaxiPricingCategory(
        variables: Variables$Mutation$createTaxiPricingCategory(
          input: Input$ServiceCategoryInput(name: name),
        ),
      ),
    );
    return result.mapData((r) => r.createOneServiceCategory);
  }

  @override
  Future<ApiResponse<void>> delete({required String id}) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$deleteTaxiPricingCategory(
        variables: Variables$Mutation$deleteTaxiPricingCategory(id: id),
      ),
    );
    return result.mapData((r) => r.deleteOneServiceCategory);
  }

  @override
  Future<ApiResponse<List<Fragment$taxiPricingCategory>>> getAll() async {
    final result = await graphQLDatasource.query(
      Options$Query$taxiPricingCategories(),
    );
    return result.mapData((r) => r.serviceCategories);
  }

  @override
  Future<ApiResponse<Fragment$taxiPricingCategory>> getById({
    required String id,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$taxiPricingCategory(
        variables: Variables$Query$taxiPricingCategory(id: id),
      ),
    );
    return result.mapData((r) => r.serviceCategory);
  }

  @override
  Future<ApiResponse<Fragment$taxiPricingCategory>> update({
    required String id,
    required String name,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$updateTaxiPricingCategory(
        variables: Variables$Mutation$updateTaxiPricingCategory(
          id: id,
          input: Input$ServiceCategoryInput(name: name),
        ),
      ),
    );
    return result.mapData((r) => r.updateOneServiceCategory);
  }
}
