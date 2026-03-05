import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class ParkingDispatcherRepository {
  Future<ApiResponse<List<Fragment$parkSpotDetail>>> getParkings({
    required Fragment$Coordinate location,
    required DateTime fromTime,
    required DateTime toTime,
  });

  Future<ApiResponse<String>> createOrder({
    required String parkingId,
    required (DateTime, DateTime) enterExitTime,
    required Enum$ParkSpotVehicleType vehicleType,
  });
}
