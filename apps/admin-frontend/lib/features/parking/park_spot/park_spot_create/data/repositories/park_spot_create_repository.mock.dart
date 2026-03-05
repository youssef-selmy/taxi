import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_create/data/repositories/park_spot_create_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ParkSpotCreateRepository)
class ParkSpotCreateRepositoryMock implements ParkSpotCreateRepository {
  @override
  Future<ApiResponse<Fragment$parkSpotDetail>> getParkSpotDetail({
    required String parkSpotId,
  }) async {
    return ApiResponse.loaded(mockParkSpotDetail);
  }

  @override
  Future<ApiResponse<Fragment$parkSpotDetail>> createParkSpot({
    required Input$CreateParkSpotInput input,
  }) async {
    return ApiResponse.loaded(mockParkSpotDetail);
  }
}
