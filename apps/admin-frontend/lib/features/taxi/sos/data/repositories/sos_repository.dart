import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/distress_signal.graphql.dart';
import 'package:admin_frontend/features/taxi/sos/data/graphql/sos.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class SosRepository {
  Future<ApiResponse<Query$distressSignals>> getAll({
    required Input$OffsetPaging? paging,
    required Input$DistressSignalFilter filter,
    required List<Input$DistressSignalSort> sorting,
  });

  Future<ApiResponse<Fragment$distressSignalDetail>> getOne({
    required String id,
  });

  Future<ApiResponse<Fragment$distressSignalDetail>> update({
    required String id,
    required Input$UpdateSosInput update,
  });
}
