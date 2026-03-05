import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_support_request.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_detail/data/graphql/taxi_support_request_detail.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_support_request/taxi_support_request_detail/data/repositories/taxi_support_request_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: TaxiSupportRequestDetailRepository)
class TaxiSupportRequestDetailRepositoryImpl
    implements TaxiSupportRequestDetailRepository {
  final GraphqlDatasource graphQLDatasource;

  TaxiSupportRequestDetailRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$taxiSupportRequest>> getSupportRequest({
    required String id,
  }) async {
    final supportRequestOrError = await graphQLDatasource.query(
      Options$Query$taxiSupportRequest(
        variables: Variables$Query$taxiSupportRequest(id: id),
      ),
    );
    return supportRequestOrError;
  }

  @override
  Future<ApiResponse<Fragment$taxiSupportRequestActivity>> addComment({
    required Input$CreateTaxiSupportRequestCommentInput input,
  }) async {
    final addCommentSupport = await graphQLDatasource.mutate(
      Options$Mutation$addCommentSupportRequestActivity(
        variables: Variables$Mutation$addCommentSupportRequestActivity(
          input: input,
        ),
      ),
    );
    return addCommentSupport.mapData((f) => f.addCommentToTaxiSupportRequest);
  }

  @override
  Future<ApiResponse<Fragment$taxiSupportRequestActivity>> assignToStaffs({
    required Input$AssignTaxiSupportRequestInput input,
  }) async {
    final assignSupportRequest = await graphQLDatasource.mutate(
      Options$Mutation$assignSupportRequestActivity(
        variables: Variables$Mutation$assignSupportRequestActivity(
          input: input,
        ),
      ),
    );
    return assignSupportRequest.mapData(
      (f) => f.assignTaxiSupportRequestToStaff,
    );
  }

  @override
  Future<ApiResponse<Fragment$taxiSupportRequestActivity>> updateStatus({
    required Input$ChangeTaxiSupportRequestStatusInput input,
  }) async {
    final changeSupportRequest = await graphQLDatasource.mutate(
      Options$Mutation$changeSupportRequestStatus(
        variables: Variables$Mutation$changeSupportRequestStatus(input: input),
      ),
    );
    return changeSupportRequest.mapData(
      (f) => f.changeTaxiSupportRequestStatus,
    );
  }
}
