import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/region.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/region.graphql.mock.dart';
import 'package:admin_frontend/features/management_common/regions/data/repositories/region_category_details_repository.dart';

@dev
@LazySingleton(as: RegionCategoryDetailsRepository)
class RegionCategoryDetailsRepositoryMock
    implements RegionCategoryDetailsRepository {
  @override
  Future<ApiResponse<Fragment$regionCategory>> createRegionCategory({
    required String name,
    required String currency,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockRegionCategory1);
  }

  @override
  Future<ApiResponse<String>> deleteRegionCategory(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(id);
  }

  @override
  Future<ApiResponse<Fragment$regionCategory>> updateRegionCategory({
    required String id,
    required String name,
    required String currency,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockRegionCategory1);
  }

  @override
  Future<ApiResponse<Fragment$regionCategory>> getRegionCategory({
    required String regionCategoryId,
  }) async {
    return ApiResponse.loaded(mockRegionCategory1);
  }
}
