import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.dart';

abstract class PricingCategoryRepository {
  Future<ApiResponse<List<Fragment$taxiPricingCategory>>> getAll();
  Future<ApiResponse<Fragment$taxiPricingCategory>> getById({
    required String id,
  });
  Future<ApiResponse<Fragment$taxiPricingCategory>> create({
    required String name,
  });
  Future<ApiResponse<Fragment$taxiPricingCategory>> update({
    required String id,
    required String name,
  });
  Future<ApiResponse<void>> delete({required String id});
}
