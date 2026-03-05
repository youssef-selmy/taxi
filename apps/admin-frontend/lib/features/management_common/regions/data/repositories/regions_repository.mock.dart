import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/region.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/region.graphql.mock.dart';
import 'package:admin_frontend/features/management_common/regions/data/graphql/regions.graphql.dart';
import 'package:admin_frontend/features/management_common/regions/data/repositories/regions_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: RegionsRepository)
class RegionsRepositoryMock implements RegionsRepository {
  @override
  Future<ApiResponse<List<Fragment$regionCategory>>>
  getRegionCategories() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded([mockRegionCategory1, mockRegionCategory2]);
  }

  @override
  Future<ApiResponse<Query$regions>> getRegions({
    required String? regionCategoryId,
    required String? query,
    required Input$OffsetPaging? paging,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$regions(
        regions: Query$regions$regions(
          nodes: [mockRegion1, mockRegion2],
          totalCount: 2,
          pageInfo: mockPageInfo,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<List<Fragment$nameCount>>> getRegionPopularity() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockRegionPopularityChart);
  }
}

final mockRegionPopularityChart = mockRegionCategories
    .map(
      (e) => Fragment$nameCount(
        name: e.name,
        // a random number between 10000 and 800000
        count: (10000 + (800000 - 10000) * (e.id.hashCode % 1000) / 1000)
            .round(),
      ),
    )
    .toList();
