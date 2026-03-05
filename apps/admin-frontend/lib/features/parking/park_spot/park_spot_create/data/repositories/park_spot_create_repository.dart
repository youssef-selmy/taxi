import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ParkSpotCreateRepository {
  Future<ApiResponse<Fragment$parkSpotDetail>> getParkSpotDetail({
    required String parkSpotId,
  });

  Future<ApiResponse<Fragment$parkSpotDetail>> createParkSpot({
    required Input$CreateParkSpotInput input,
  });
}
