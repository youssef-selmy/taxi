import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/distress_signal.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/distress_signal.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/features/taxi/sos/data/graphql/sos.graphql.dart';
import 'package:admin_frontend/features/taxi/sos/data/repositories/sos_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: SosRepository)
class SosRepositoryMock implements SosRepository {
  @override
  Future<ApiResponse<Query$distressSignals>> getAll({
    required Input$OffsetPaging? paging,
    required Input$DistressSignalFilter filter,
    required List<Input$DistressSignalSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$distressSignals(
        distressSignals: Query$distressSignals$distressSignals(
          pageInfo: mockPageInfo,
          totalCount: mockDistressSingnalList.length,
          nodes: mockDistressSingnalList,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$distressSignalDetail>> getOne({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockDistressSingnalDetail);
  }

  @override
  Future<ApiResponse<Fragment$distressSignalDetail>> update({
    required String id,
    required Input$UpdateSosInput update,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockDistressSingnalDetail);
  }
}
