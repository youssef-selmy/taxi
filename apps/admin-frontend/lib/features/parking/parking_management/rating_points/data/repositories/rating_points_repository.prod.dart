import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.dart';
import 'package:admin_frontend/features/parking/parking_management/rating_points/data/graphql/rating_points.graphql.dart';
import 'package:admin_frontend/features/parking/parking_management/rating_points/data/repositories/rating_points_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ParkingRatingPointsRepository)
class ParkingRatingPointsRepositoryImpl
    implements ParkingRatingPointsRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkingRatingPointsRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<List<Fragment$parkingFeedbackParameterListItem>>>
  getRatingPoints() async {
    final points = await graphQLDatasource.query(Options$Query$ratingPoints());
    return points.mapData((r) => r.ratingPoints);
  }

  @override
  Future<ApiResponse<Fragment$parkingFeedbackParameterListItem>>
  createRatingPoint({
    required Input$CreateParkingFeedbackParameter input,
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
  Future<ApiResponse<Fragment$parkingFeedbackParameterListItem>>
  getRatingPoint({required String id}) async {
    final result = await graphQLDatasource.query(
      Options$Query$ratingPoint(variables: Variables$Query$ratingPoint(id: id)),
    );
    return result.mapData((r) => r.ratingPoint);
  }

  @override
  Future<ApiResponse<Fragment$parkingFeedbackParameterListItem>>
  updateRatingPoint({
    required String id,
    required Input$UpdateParkingFeedbackParameter input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$updateRatingPoint(
        variables: Variables$Mutation$updateRatingPoint(id: id, input: input),
      ),
    );
    return result.mapData((r) => r.updateRatingPoint);
  }
}
