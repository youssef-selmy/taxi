import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.dart';
import 'package:admin_frontend/features/parking/parking_review/parking_review_list/data/graphql/parking_review_list.graphql.dart';
import 'package:admin_frontend/features/parking/parking_review/parking_review_list/data/repositories/parking_review_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ParkingReviewListRepository)
class ParkingReviewListRepositoryImpl implements ParkingReviewListRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkingReviewListRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$parkingFeedbacks>> getParkingReviewsList({
    required Input$OffsetPaging? paging,
    required Input$ParkingFeedbackFilter filter,
    required List<Input$ParkingFeedbackSort> sorting,
  }) async {
    final getParkingReviewsList = await graphQLDatasource.query(
      Options$Query$parkingFeedbacks(
        variables: Variables$Query$parkingFeedbacks(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return getParkingReviewsList;
  }

  @override
  Future<ApiResponse<Fragment$parkingFeedback>> updateParkingFeedbackStatus({
    required String id,
    required Enum$ReviewStatus status,
  }) async {
    final updateOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateParkingFeedbackStatus(
        variables: Variables$Mutation$updateParkingFeedbackStatus(
          feedbackId: id,
          status: status,
        ),
      ),
    );
    return updateOrError.mapData((f) => f.updateParkingFeedbackStatus);
  }
}
