import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.mock.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ParkSpotDetailRepository)
class ParkSpotDetailRepositoryMock implements ParkSpotDetailRepository {
  @override
  Future<ApiResponse<Fragment$parkSpotDetail>> getParkSpotDetail({
    required String parkSpotId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockParkSpotDetail);
  }

  @override
  Future<ApiResponse<Query$parkSpotFeedbacks>> getParkSpotFeedbacks({
    required String parkSpotId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$parkSpotFeedbacks(
        parkingFeedbacks: Query$parkSpotFeedbacks$parkingFeedbacks(
          nodes: mockParkingFeedbacks,
          pageInfo: mockPageInfo,
          totalCount: mockParkingFeedbacks.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$parkSpotDetail>> updateParkSpot({
    required String parkSpotId,
    required Input$UpdateParkSpotInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(mockParkSpotDetail);
  }
}
