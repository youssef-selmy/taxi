import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/distress_signal.graphql.dart';
import 'package:admin_frontend/features/taxi/sos/data/graphql/sos.graphql.dart';
import 'package:admin_frontend/features/taxi/sos/data/repositories/sos_reasson_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: SosReassonRepository)
class SosReassonRepositoryImpl implements SosReassonRepository {
  final GraphqlDatasource graphQLDatasource;

  SosReassonRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$sosReasons>> getAll({
    required Input$OffsetPaging? paging,
    required Input$SOSReasonFilter filter,
    required List<Input$SOSReasonSort> sorting,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$sosReasons(
        variables: Variables$Query$sosReasons(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return result;
  }

  @override
  Future<ApiResponse<Fragment$SosReassonDetail>> getOne({
    required String id,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$sosReasonDetail(
        variables: Variables$Query$sosReasonDetail(id: id),
      ),
    );
    return result.mapData((f) => f.sosReason);
  }

  @override
  Future<ApiResponse<Fragment$SosReassonDetail>> create({
    required Input$CreateOneSOSReasonInput input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$sosReasonCreate(
        variables: Variables$Mutation$sosReasonCreate(input: input),
      ),
    );
    return result.mapData((f) => f.createOneSOSReason);
  }

  @override
  Future<ApiResponse<Fragment$SosReassonDetail>> update({
    required Input$UpdateOneSOSReasonInput input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$sosReasonUpdate(
        variables: Variables$Mutation$sosReasonUpdate(input: input),
      ),
    );
    return result.mapData((f) => f.updateOneSOSReason);
  }

  @override
  Future<ApiResponse<bool>> delete({required String id}) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$sosReasonDelete(
        variables: Variables$Mutation$sosReasonDelete(id: id),
      ),
    );
    return result.mapData((r) => true);
  }

  @override
  Future<ApiResponse<bool>> hideReasson({
    required Input$UpdateOneSOSReasonInput input,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$sosReasonUpdate(
        variables: Variables$Mutation$sosReasonUpdate(input: input),
      ),
    );
    return result.mapData((r) => true);
  }
}
