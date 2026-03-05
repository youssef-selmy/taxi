import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/distress_signal.graphql.dart';
import 'package:admin_frontend/features/taxi/sos/data/graphql/sos.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class SosReassonRepository {
  Future<ApiResponse<Query$sosReasons>> getAll({
    required Input$OffsetPaging? paging,
    required Input$SOSReasonFilter filter,
    required List<Input$SOSReasonSort> sorting,
  });

  Future<ApiResponse<Fragment$SosReassonDetail>> getOne({required String id});

  Future<ApiResponse<Fragment$SosReassonDetail>> update({
    required Input$UpdateOneSOSReasonInput input,
  });

  Future<ApiResponse<Fragment$SosReassonDetail>> create({
    required Input$CreateOneSOSReasonInput input,
  });

  Future<ApiResponse<bool>> hideReasson({
    required Input$UpdateOneSOSReasonInput input,
  });

  Future<ApiResponse<bool>> delete({required String id});
}
