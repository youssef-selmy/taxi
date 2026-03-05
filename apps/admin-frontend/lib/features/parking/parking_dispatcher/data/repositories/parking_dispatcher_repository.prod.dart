import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/data/graphql/create_order.graphql.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/data/graphql/get_parkings.graphql.dart';
import 'package:admin_frontend/features/parking/parking_dispatcher/data/repositories/parking_dispatcher_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ParkingDispatcherRepository)
class ParkingDispatcherRepositoryImpl implements ParkingDispatcherRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkingDispatcherRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<List<Fragment$parkSpotDetail>>> getParkings({
    required Fragment$Coordinate location,
    required DateTime fromTime,
    required DateTime toTime,
  }) async {
    final parkings = await graphQLDatasource.query(
      Options$Query$parkings(
        variables: Variables$Query$parkings(
          location: location.toPointInput(),
          fromTime: fromTime,
          toTime: toTime,
        ),
      ),
    );
    return parkings.mapData((e) => e.parkings);
  }

  @override
  Future<ApiResponse<String>> createOrder({
    required String parkingId,
    required (DateTime, DateTime) enterExitTime,
    required Enum$ParkSpotVehicleType vehicleType,
  }) async {
    final order = await graphQLDatasource.mutate(
      Options$Mutation$createParkingOrder(
        variables: Variables$Mutation$createParkingOrder(
          input: Input$CreateParkOrderInput(
            parkSpotId: parkingId,
            enterTime: enterExitTime.$1,
            exitTime: enterExitTime.$2,
            vehicleType: vehicleType,
            paymentMode: Enum$PaymentMode.Cash,
          ),
        ),
      ),
    );
    return order.mapData((e) => e.createOneParkOrder.id);
  }
}
