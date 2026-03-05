import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_support_request.fragment.graphql.dart';
import 'package:admin_frontend/features/parking/parking_support_request/parking_support_request_detail/data/graphql/parking_support_request_detail.graphql.dart';
import 'package:admin_frontend/features/parking/parking_support_request/parking_support_request_detail/data/repositories/parking_support_request_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ParkingSupportRequestDetailRepository)
class ParkingSupportRequestDetailRepositoryImpl
    implements ParkingSupportRequestDetailRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkingSupportRequestDetailRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$parkingSupportRequest>> getSupportRequest({
    required String id,
  }) async {
    final supportRequestOrError = await graphQLDatasource.query(
      Options$Query$parkingSupportRequest(
        variables: Variables$Query$parkingSupportRequest(id: id),
      ),
    );
    return supportRequestOrError;
  }

  @override
  Future<ApiResponse<Fragment$parkingSupportRequestActivity>> addComment({
    required Input$CreateParkingSupportRequestCommentInput input,
  }) async {
    final addCommentSupport = await graphQLDatasource.mutate(
      Options$Mutation$addCommentToParkingSupportRequest(
        variables: Variables$Mutation$addCommentToParkingSupportRequest(
          input: input,
        ),
      ),
    );
    return addCommentSupport.mapData(
      (f) => f.addCommentToParkingSupportRequest,
    );
  }

  @override
  Future<ApiResponse<Fragment$parkingSupportRequestActivity>> assignToStaffs({
    required Input$AssignParkingSupportRequestInput input,
  }) async {
    final assignSupportRequest = await graphQLDatasource.mutate(
      Options$Mutation$assignStaffsToParkingSupportRequest(
        variables: Variables$Mutation$assignStaffsToParkingSupportRequest(
          input: input,
        ),
      ),
    );
    return assignSupportRequest.mapData(
      (f) => f.assignParkingSupportRequestToStaff,
    );
  }

  @override
  Future<ApiResponse<Fragment$parkingSupportRequestActivity>> updateStatus({
    required Input$ChangeParkingSupportRequestStatusInput input,
  }) async {
    final changeSupportRequest = await graphQLDatasource.mutate(
      Options$Mutation$updateParkingSupportRequestStatus(
        variables: Variables$Mutation$updateParkingSupportRequestStatus(
          input: input,
        ),
      ),
    );
    return changeSupportRequest.mapData(
      (f) => f.changeParkingSupportRequestStatus,
    );
  }
}
