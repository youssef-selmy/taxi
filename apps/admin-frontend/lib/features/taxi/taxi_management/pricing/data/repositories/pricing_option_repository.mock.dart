import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/taxi_order_option.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order_option.graphql.extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/pricing_option_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: PricingOptionRepository)
class PricingOptionRepositoryMock implements PricingOptionRepository {
  @override
  Future<ApiResponse<Fragment$taxiOrderOption>> create({
    required Input$ServiceOptionInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockTaxiOrderOption1);
  }

  @override
  Future<ApiResponse<void>> delete({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const ApiResponse.loaded(null);
  }

  @override
  Future<ApiResponse<List<Fragment$taxiOrderOption>>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockTaxiOrderOptions);
  }

  @override
  Future<ApiResponse<Fragment$taxiOrderOption>> getById({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockTaxiOrderOption1);
  }

  @override
  Future<ApiResponse<Fragment$taxiOrderOption>> update({
    required String id,
    required Input$ServiceOptionInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockTaxiOrderOption1);
  }
}
