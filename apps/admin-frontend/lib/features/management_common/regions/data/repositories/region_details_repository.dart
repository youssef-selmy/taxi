import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/region.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class RegionDetailsRepository {
  Future<ApiResponse<Fragment$region>> createRegion({
    required Input$CreateRegionInput input,
  });

  Future<ApiResponse<Fragment$region>> updateRegion({
    required String id,
    required Input$UpdateRegionInput input,
  });

  Future<ApiResponse<Fragment$region>> getRegion({required String regionId});

  Future<ApiResponse<String>> deleteRegion(String id);
}
