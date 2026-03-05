import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/parking/park_spot/park_spot_list/data/graphql/park_spot_list.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ParkSpotListRepository {
  Future<ApiResponse<Query$parkSpots>> getParkSpots({
    required Input$OffsetPaging? paging,
    required Input$ParkSpotFilter filter,
    required List<Input$ParkSpotSort> sorting,
  });
}
