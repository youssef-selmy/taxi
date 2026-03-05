import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/driver.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/data/graphql/driver_list.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/data/repositories/driver_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: DriverListRepository)
class DriverListRepositoryMock implements DriverListRepository {
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
          totalCount: mockDriverListItems.length,
          pageInfo: mockPageInfo,
          nodes: mockDriverListItems,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Mutation$updateOneDriver>> updateDriver({
    required Input$UpdateOneDriverInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$updateOneDriver(updateOneDriver: mockDriverListItem1),
    );
  }

  @override
  Future<ApiResponse<Mutation$updateDriverStatus>> updateDriverStatus({
    required String id,
    required Enum$DriverStatus status,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$updateDriverStatus(updateDriverStatus: mockDriverListItem1),
    );
  }
}
