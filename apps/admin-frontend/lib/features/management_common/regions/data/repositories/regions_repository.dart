import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/region.graphql.dart';
import 'package:admin_frontend/features/management_common/regions/data/graphql/regions.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class RegionsRepository {
  Future<ApiResponse<List<Fragment$regionCategory>>> getRegionCategories();

  Future<ApiResponse<Query$regions>> getRegions({
    required String? regionCategoryId,
    required String? query,
    required Input$OffsetPaging? paging,
  });

  Future<ApiResponse<List<Fragment$nameCount>>> getRegionPopularity();
}
