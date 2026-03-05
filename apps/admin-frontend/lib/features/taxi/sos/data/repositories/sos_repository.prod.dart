import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/distress_signal.graphql.dart';
import 'package:admin_frontend/features/taxi/sos/data/graphql/sos.graphql.dart';
import 'package:admin_frontend/features/taxi/sos/data/repositories/sos_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: SosRepository)
class SosRepositoryImpl implements SosRepository {
  final GraphqlDatasource graphQLDatasource;

  SosRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$distressSignals>> getAll({
    required Input$OffsetPaging? paging,
    required Input$DistressSignalFilter filter,
    required List<Input$DistressSignalSort> sorting,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$distressSignals(
        variables: Variables$Query$distressSignals(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return result;
  }

  @override
  Future<ApiResponse<Fragment$distressSignalDetail>> getOne({
    required String id,
  }) async {
    final result = await graphQLDatasource.query(
      Options$Query$distressSignalDetails(
        variables: Variables$Query$distressSignalDetails(id: id),
      ),
    );
    return result.mapData((f) => f.distressSignal);
  }

  @override
  Future<ApiResponse<Fragment$distressSignalDetail>> update({
    required String id,
    required Input$UpdateSosInput update,
  }) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$updateSos(
        variables: Variables$Mutation$updateSos(id: id, update: update),
      ),
    );
    return result.mapData((f) => f.updateOneDistressSignal);
  }
}
