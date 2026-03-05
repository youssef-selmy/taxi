import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/zone_price.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/zone_price.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/data/repositories/zone_price_category_repository.dart';

@dev
@LazySingleton(as: ZonePriceCategoryRepository)
class ZonePriceCategoryRepositoryMock implements ZonePriceCategoryRepository {
  @override
  Future<ApiResponse<Fragment$zonePriceCategory>> create({
    required String name,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockZonePriceCategory1);
  }

  @override
  Future<ApiResponse<String>> delete(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(id);
  }

  @override
  Future<ApiResponse<List<Fragment$zonePriceCategory>>> getAll() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockZonePriceCategoies);
  }

  @override
  Future<ApiResponse<Fragment$zonePriceCategory>> getOne({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockZonePriceCategory1);
  }

  @override
  Future<ApiResponse<Fragment$zonePriceCategory>> update({
    required String id,
    required String name,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockZonePriceCategory1);
  }
}
