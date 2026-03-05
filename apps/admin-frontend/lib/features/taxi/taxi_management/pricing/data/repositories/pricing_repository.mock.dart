import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/region.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order_option.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/graphql/pricing.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/pricing_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: PricingRepository)
class PricingRepositoryMock implements PricingRepository {
  @override
  Future<ApiResponse<Fragment$taxiPricing>> create({
    required Input$ServiceInput input,
    required List<String> regionIds,
    required List<String> optionIds,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockTaxiPricing1);
  }

  @override
  Future<ApiResponse<void>> delete({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<List<Fragment$taxiPricingListItem>>> getAll({
    required String? categoryId,
    required String? searchQuery,
    required Input$OffsetPaging? paging,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(taxiPricingListItems);
  }

  @override
  Future<ApiResponse<Query$taxiPricing>> getById({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(Query$taxiPricing(service: mockTaxiPricing1));
  }

  @override
  Future<ApiResponse<Fragment$taxiPricing>> update({
    required String id,
    required Input$ServiceInput input,
    required List<String> regionIds,
    required List<String> optionIds,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockTaxiPricing1);
  }

  @override
  Future<ApiResponse<Query$taxiPricingFieldOptions>> getFieldOptions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$taxiPricingFieldOptions(
        serviceCategories: mockTaxiPricingCategories,
        serviceOptions: mockTaxiOrderOptions,
        regions: Query$taxiPricingFieldOptions$regions(
          nodes: mockRegionWithCategories,
        ),
      ),
    );
  }
}
