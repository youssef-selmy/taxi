import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_list/data/graphql/park_spot_list.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_list/data/repositories/park_spot_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ParkSpotListRepository)
class ParkSpotListRepositoryMock implements ParkSpotListRepository {
  @override
  Future<ApiResponse<Query$parkSpots>> getParkSpots({
    required Input$OffsetPaging? paging,
    required Input$ParkSpotFilter filter,
    required List<Input$ParkSpotSort> sorting,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkSpots(
        parkSpots: Query$parkSpots$parkSpots(
          nodes: mockParkingListItems,
          pageInfo: mockPageInfo,
          totalCount: mockParkingListItems.length,
        ),
      ),
    );
  }
}
