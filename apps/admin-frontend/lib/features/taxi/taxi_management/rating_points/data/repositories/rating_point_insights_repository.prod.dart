import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/rating_points/data/graphql/rating_point_insights.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/rating_points/data/repositories/rating_point_insights_repository.dart';

@prod
@LazySingleton(as: RatingPointInsightsRepository)
class RatingPointInsightsRepositoryImpl
    implements RatingPointInsightsRepository {
  final GraphqlDatasource graphQLDatasource;

  RatingPointInsightsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<List<Fragment$nameCount>>> getRatingPointInsights() async {
    final insights = await graphQLDatasource.query(
      Options$Query$ratingPointPopularities(),
    );
    return insights.mapData((r) => r.ratingPointPopularities);
  }
}
