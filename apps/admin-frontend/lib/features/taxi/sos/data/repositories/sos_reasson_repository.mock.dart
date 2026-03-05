import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/distress_signal.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/distress_signal.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/features/taxi/sos/data/graphql/sos.graphql.dart';
import 'package:admin_frontend/features/taxi/sos/data/repositories/sos_reasson_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: SosReassonRepository)
class SosReassonRepositoryMock implements SosReassonRepository {
  @override
  Future<ApiResponse<Query$sosReasons>> getAll({
    required Input$OffsetPaging? paging,
    required Input$SOSReasonFilter filter,
    required List<Input$SOSReasonSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$sosReasons(
        sosReasons: Query$sosReasons$sosReasons(
          pageInfo: mockPageInfo,
          totalCount: mockSosReasonList.length,
          nodes: mockSosReasonList,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$SosReassonDetail>> getOne({
    required String id,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockSosReasonDetail1);
  }

  @override
  Future<ApiResponse<Fragment$SosReassonDetail>> create({
    required Input$CreateOneSOSReasonInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockSosReasonDetail1);
  }

  @override
  Future<ApiResponse<Fragment$SosReassonDetail>> update({
    required Input$UpdateOneSOSReasonInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockSosReasonDetail1);
  }

  @override
  Future<ApiResponse<bool>> delete({required String id}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const ApiResponse.loaded(true);
  }

  @override
  Future<ApiResponse<bool>> hideReasson({
    required Input$UpdateOneSOSReasonInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const ApiResponse.loaded(true);
  }
}
