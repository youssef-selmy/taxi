import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/region.graphql.dart';

abstract class RegionCategoryDetailsRepository {
  Future<ApiResponse<Fragment$regionCategory>> createRegionCategory({
    required String name,
    required String currency,
  });

  Future<ApiResponse<Fragment$regionCategory>> updateRegionCategory({
    required String id,
    required String name,
    required String currency,
  });
  Future<ApiResponse<String>> deleteRegionCategory(String id);

  Future<ApiResponse<Fragment$regionCategory>> getRegionCategory({
    required String regionCategoryId,
  });
}
