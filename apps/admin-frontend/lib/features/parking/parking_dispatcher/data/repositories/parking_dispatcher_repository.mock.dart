import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.mock.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/data/repositories/parking_dispatcher_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: ParkingDispatcherRepository)
class ParkingDispatcherRepositoryMock implements ParkingDispatcherRepository {
  @override
  Future<ApiResponse<List<Fragment$parkSpotDetail>>> getParkings({
    required Fragment$Coordinate location,
    required DateTime fromTime,
    required DateTime toTime,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(List.generate(10, (_) => mockParkSpotDetail));
  }

  @override
  Future<ApiResponse<String>> createOrder({
    required String parkingId,
    required (DateTime, DateTime) enterExitTime,
    required Enum$ParkSpotVehicleType vehicleType,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const ApiResponse.loaded("1");
  }
}
