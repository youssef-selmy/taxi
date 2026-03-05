import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/driver.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_list/data/graphql/driver_pending_verification_list.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_list/data/repositories/driver_pending_verification_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: DriverPendingVerificationListRepository)
class DriverPendingVerificationListRepositoryMock
    implements DriverPendingVerificationListRepository {
  @override
  Future<ApiResponse<Query$drivers>> getDrivers({
    required Input$OffsetPaging? paging,
    required Input$DriverFilter filter,
    required List<Input$DriverSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$drivers(
        drivers: Query$drivers$drivers(
          totalCount: mockDriverList.length,
          pageInfo: mockPageInfo,
          nodes: mockDriverList,
        ),
      ),
    );
  }
}
