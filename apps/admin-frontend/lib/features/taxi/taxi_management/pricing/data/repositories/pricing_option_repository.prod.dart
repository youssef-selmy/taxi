import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order_option.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/graphql/pricing_option.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/pricing_option_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: PricingOptionRepository)
class PricingOptionRepositoryImpl implements PricingOptionRepository {
  final GraphqlDatasource graphQLDatasource;

  PricingOptionRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$taxiOrderOption>> create({
    required Input$ServiceOptionInput input,
  }) async {
    final pricingOptionOrError = await graphQLDatasource.mutate(
      Options$Mutation$createPricingOption(
        variables: Variables$Mutation$createPricingOption(input: input),
      ),
    );
    return pricingOptionOrError.mapData((r) => r.createPricingOption);
  }

  @override
  Future<ApiResponse<void>> delete({required String id}) async {
    final deleteResultOrError = await graphQLDatasource.mutate(
      Options$Mutation$deletePricingOption(
        variables: Variables$Mutation$deletePricingOption(id: id),
      ),
    );
    return deleteResultOrError;
  }

  @override
  Future<ApiResponse<List<Fragment$taxiOrderOption>>> getAll() async {
    final pricingOptionsOrError = await graphQLDatasource.query(
      Options$Query$taxiPricingOptions(),
    );
    return pricingOptionsOrError.mapData((r) => r.taxiPricingOptions);
  }

  @override
  Future<ApiResponse<Fragment$taxiOrderOption>> getById({
    required String id,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$taxiPricingOption(
        variables: Variables$Query$taxiPricingOption(id: id),
      ),
    );
    return result.mapData((r) => r.taxiPricingOption);
  }

  @override
  Future<ApiResponse<Fragment$taxiOrderOption>> update({
    required String id,
    required Input$ServiceOptionInput input,
  }) async {
    final pricingOptionOrError = await graphQLDatasource.mutate(
      Options$Mutation$updatePricingOption(
        variables: Variables$Mutation$updatePricingOption(id: id, input: input),
      ),
    );
    return pricingOptionOrError.mapData((r) => r.updatePricingOption);
  }
}
