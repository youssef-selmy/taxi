import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/pricing_category_repository.dart';

@dev
@LazySingleton(as: PricingCategoryRepository)
class PricingCategoryRepositoryMock implements PricingCategoryRepository {
  @override
  Future<ApiResponse<Fragment$taxiPricingCategory>> create({
    required String name,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockTaxiPricingCategory1);
  }

  @override
  Future<ApiResponse<List<Fragment$taxiPricingCategory>>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockTaxiPricingCategories);
  }

  @override
  Future<ApiResponse<Fragment$taxiPricingCategory>> getById({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockTaxiPricingCategory1);
  }

  @override
  Future<ApiResponse<Fragment$taxiPricingCategory>> update({
    required String id,
    required String name,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockTaxiPricingCategory1);
  }

  @override
  Future<ApiResponse<void>> delete({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const ApiResponse.loaded(null);
  }
}
