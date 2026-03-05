import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/cancel_reason.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/data/graphql/cancel_reason.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/data/repositories/cancel_reason_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: CancelReasonRepository)
class CancelReasonRepositoryImpl implements CancelReasonRepository {
  final GraphqlDatasource graphQLDatasource;

  CancelReasonRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<List<Fragment$cancelReason>>> getCancelReasons() async {
    final reasons = await graphQLDatasource.query(
      Options$Query$cancelReasons(),
    );
    return reasons.mapData((r) => r.orderCancelReasons.nodes);
  }

  @override
  Future<ApiResponse<Fragment$cancelReason>> createCancelReason({
    required Input$OrderCancelReasonInput input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$createCancelReason(
        variables: Variables$Mutation$createCancelReason(input: input),
      ),
    );
    return result.mapData((r) => r.createOneOrderCancelReason);
  }

  @override
  Future<ApiResponse<void>> deleteCancelReason({required String id}) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$deleteCancelReason(
        variables: Variables$Mutation$deleteCancelReason(id: id),
      ),
    );
    return result;
  }

  @override
  Future<ApiResponse<Fragment$cancelReason>> getCancelReason({
    required String id,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$cancelReason(
        variables: Variables$Query$cancelReason(id: id),
      ),
    );
    return result.mapData((r) => r.orderCancelReason);
  }

  @override
  Future<ApiResponse<Fragment$cancelReason>> updateCancelReason({
    required String id,
    required Input$OrderCancelReasonInput input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$updateCancelReason(
        variables: Variables$Mutation$updateCancelReason(id: id, input: input),
      ),
    );
    return result.mapData((r) => r.updateOneOrderCancelReason);
  }
}
