import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ParkSpotDetailRepository {
  Future<ApiResponse<Fragment$parkSpotDetail>> getParkSpotDetail({
    required String parkSpotId,
  });

  Future<ApiResponse<Query$parkSpotFeedbacks>> getParkSpotFeedbacks({
    required String parkSpotId,
  });

  Future<ApiResponse<Fragment$parkSpotDetail>> updateParkSpot({
    required String parkSpotId,
    required Input$UpdateParkSpotInput input,
  });
}
