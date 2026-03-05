import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_location.fragment.graphql.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/data/graphql/taxi_calculate_fare.graphql.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/data/repositories/dispatcher_taxi_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: DispatcherTaxiRepository)
class DispatcherTaxiRepositoryImpl implements DispatcherTaxiRepository {
  final GraphqlDatasource graphQLDatasource;

  DispatcherTaxiRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$CalculateFare>> calculateFare({
    required String customerId,
    required List<Fragment$Place> locations,
  }) async {
    final fare = await graphQLDatasource.query(
      Options$Query$CalculateFare(
        variables: Variables$Query$CalculateFare(
          input: Input$CalculateFareInput(
            riderId: customerId,
            orderType: Enum$TaxiOrderType.Ride,
            points: locations.toPointInputList(),
          ),
        ),
      ),
    );

    return fare;
  }

  @override
  Future<ApiResponse<List<Fragment$DriverLocation>>> getDriverLocations({
    required Fragment$Coordinate location,
  }) async {
    final driverLocations = await graphQLDatasource.query(
      Options$Query$getDriversLocation(
        variables: Variables$Query$getDriversLocation(
          coordinate: location.toPointInput(),
        ),
      ),
    );

    return driverLocations.mapData((e) => e.getDriversLocationWithData);
  }

  @override
  Future<ApiResponse<Mutation$createTaxiOrder>> createOrder({
    required Input$CreateOrderInput input,
  }) async {
    final order = await graphQLDatasource.mutate(
      Options$Mutation$createTaxiOrder(
        variables: Variables$Mutation$createTaxiOrder(input: input),
      ),
    );
    return order;
  }
}
