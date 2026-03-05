import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/review_taxi.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/rating_points/data/graphql/rating_points.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/rating_points/data/repositories/rating_points_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: RatingPointsRepository)
class RatingPointsRepositoryImpl implements RatingPointsRepository {
  final GraphqlDatasource graphQLDatasource;

  RatingPointsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<List<Fragment$reviewTaxiParameterListItem>>>
  getRatingPoints() async {
    final points = await graphQLDatasource.query(Options$Query$ratingPoints());
    return points.mapData((r) => r.ratingPoints);
  }

  @override
  Future<ApiResponse<Fragment$reviewTaxiParameterListItem>> createRatingPoint({
    required Input$FeedbackParameterInput input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$createRatingPoint(
        variables: Variables$Mutation$createRatingPoint(input: input),
      ),
    );
    return result.mapData((r) => r.createRatingPoint);
  }

  @override
  Future<ApiResponse<bool>> deleteRatingPoint(String id) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$deleteRatingPoint(
        variables: Variables$Mutation$deleteRatingPoint(id: id),
      ),
    );
    return result.mapData((r) => true);
  }

  @override
  Future<ApiResponse<Fragment$reviewTaxiParameterListItem>> getRatingPoint({
    required String id,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$ratingPoint(variables: Variables$Query$ratingPoint(id: id)),
    );
    return result.mapData((r) => r.ratingPoint);
  }

  @override
  Future<ApiResponse<Fragment$reviewTaxiParameterListItem>> updateRatingPoint({
    required String id,
    required Input$FeedbackParameterInput input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$updateRatingPoint(
        variables: Variables$Mutation$updateRatingPoint(id: id, input: input),
      ),
    );
    return result.mapData((r) => r.updateRatingPoint);
  }
}
