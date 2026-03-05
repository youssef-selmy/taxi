import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/graphql/pricing.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/pricing_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: PricingRepository)
class PricingRepositoryImpl implements PricingRepository {
  final GraphqlDatasource graphQLDatasource;

  PricingRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$taxiPricing>> create({
    required Input$ServiceInput input,
    required List<String> regionIds,
    required List<String> optionIds,
  }) async {
    final regionResponse = await graphQLDatasource.mutate(
      Options$Mutation$createTaxiPricing(
        variables: Variables$Mutation$createTaxiPricing(input: input),
      ),
    );
    final serviceId = regionResponse.mapData((r) => r.createOneService.id);
    if (serviceId.data == null) {
      return regionResponse.mapData((r) => r.createOneService);
    }
    await graphQLDatasource.mutate(
      Options$Mutation$setRegionsOnService(
        variables: Variables$Mutation$setRegionsOnService(
          id: serviceId.data!,
          regionIds: regionIds,
        ),
      ),
    );
    await graphQLDatasource.mutate(
      Options$Mutation$setOptionsOnService(
        variables: Variables$Mutation$setOptionsOnService(
          id: serviceId.data!,
          optionIds: optionIds,
        ),
      ),
    );
    return regionResponse.mapData((r) => r.createOneService);
  }

  @override
  Future<ApiResponse<void>> delete({required String id}) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$deleteTaxiPricing(
        variables: Variables$Mutation$deleteTaxiPricing(id: id),
      ),
    );
    return result.mapData((r) => r.deleteOneService);
  }

  @override
  Future<ApiResponse<List<Fragment$taxiPricingListItem>>> getAll({
    required String? categoryId,
    required String? searchQuery,
    required Input$OffsetPaging? paging,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$taxiPricings(
        variables: Variables$Query$taxiPricings(
          filter: Input$ServiceFilter(
            categoryId: Input$IDFilterComparison(eq: categoryId),
            name: (searchQuery?.isEmpty ?? true)
                ? null
                : Input$StringFieldComparison(like: "%$searchQuery%"),
          ),
        ),
      ),
    );
    return result.mapData((r) => r.services);
  }

  @override
  Future<ApiResponse<Query$taxiPricing>> getById({required String id}) async {
    final result = await graphQLDatasource.query(
      Options$Query$taxiPricing(variables: Variables$Query$taxiPricing(id: id)),
    );
    return result;
  }

  @override
  Future<ApiResponse<Fragment$taxiPricing>> update({
    required String id,
    required Input$ServiceInput input,
    required List<String> regionIds,
    required List<String> optionIds,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$updateTaxiPricing(
        variables: Variables$Mutation$updateTaxiPricing(
          id: id,
          input: input,
          regionIds: regionIds,
          optionIds: optionIds,
        ),
      ),
    );
    return result.mapData((r) => r.updateOneService);
  }

  @override
  Future<ApiResponse<Query$taxiPricingFieldOptions>> getFieldOptions() async {
    final fieldOptionsOrResponse = await graphQLDatasource.query(
      Options$Query$taxiPricingFieldOptions(),
    );
    return fieldOptionsOrResponse;
  }
}
