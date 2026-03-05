import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/region.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/region.graphql.mock.dart';
import 'package:admin_frontend/features/management_common/regions/data/repositories/region_details_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: RegionDetailsRepository)
class RegionDetailsRepositoryMock implements RegionDetailsRepository {
  @override
  Future<ApiResponse<Fragment$region>> createRegion({
    required Input$CreateRegionInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockRegion1);
  }

  @override
  Future<ApiResponse<Fragment$region>> updateRegion({
    required String id,
    required Input$UpdateRegionInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      mockRegion1.copyWith(
        id: id,
        enabled: input.enabled ?? mockRegion1.enabled,
        name: input.name ?? mockRegion1.name,
        categoryId: input.categoryId ?? mockRegion1.categoryId,
        currency: input.currency ?? mockRegion1.currency,
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$region>> getRegion({
    required String regionId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockRegion1);
  }

  @override
  Future<ApiResponse<String>> deleteRegion(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(id);
  }
}
