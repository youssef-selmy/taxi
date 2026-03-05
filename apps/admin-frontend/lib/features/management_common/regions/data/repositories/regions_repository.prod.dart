import 'package:api_response/api_response.dart';
import 'package:graphql/client.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/region.graphql.dart';
import 'package:admin_frontend/features/management_common/regions/data/graphql/insights.graphql.dart';
import 'package:admin_frontend/features/management_common/regions/data/graphql/regions.graphql.dart';
import 'package:admin_frontend/features/management_common/regions/data/repositories/regions_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: RegionsRepository)
class RegionsRepositoryImpl implements RegionsRepository {
  final GraphqlDatasource graphQLDatasource;

  RegionsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<List<Fragment$regionCategory>>>
  getRegionCategories() async {
    final regionCategories = await graphQLDatasource.query(
      Options$Query$regionCategories(fetchPolicy: FetchPolicy.networkOnly),
    );
    return regionCategories.mapData((r) => r.regionCategories);
  }

  @override
  Future<ApiResponse<Query$regions>> getRegions({
    required String? regionCategoryId,
    required String? query,
    required Input$OffsetPaging? paging,
  }) async {
    final regions = await graphQLDatasource.query(
      Options$Query$regions(
        fetchPolicy: FetchPolicy.networkOnly,
        variables: Variables$Query$regions(
          filter: Input$RegionFilter(
            categoryId: regionCategoryId == null
                ? null
                : Input$IDFilterComparison(eq: regionCategoryId),
            name: query == null
                ? null
                : Input$StringFieldComparison(like: '%$query%'),
          ),
          paging: paging,
        ),
      ),
    );
    return regions;
  }

  @override
  Future<ApiResponse<List<Fragment$nameCount>>> getRegionPopularity() async {
    final result = await graphQLDatasource.query(
      Options$Query$regionPopularityChart(),
    );
    return result.mapData((r) => r.popularRegionsByTaxiOrders);
  }
}
