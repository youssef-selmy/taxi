import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_location.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/data/graphql/taxi_calculate_fare.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class DispatcherTaxiRepository {
  Future<ApiResponse<Query$CalculateFare>> calculateFare({
    required String customerId,
    required List<Fragment$Place> locations,
  });

  Future<ApiResponse<List<Fragment$DriverLocation>>> getDriverLocations({
    required Fragment$Coordinate location,
  });

  Future<ApiResponse<Mutation$createTaxiOrder>> createOrder({
    required Input$CreateOrderInput input,
  });
}
