import 'package:api_response/api_response.dart';
import 'package:image_faker/image_faker.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/coordinate.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_location.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_location.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/media.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_calculate_fare.fragment.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_order_option.graphql.extensions.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/data/graphql/taxi_calculate_fare.graphql.dart';
import 'package:admin_frontend/features/taxi/dispatcher_taxi/data/repositories/dispatcher_taxi_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: DispatcherTaxiRepository)
class DispatcherTaxiRepositoryMock implements DispatcherTaxiRepository {
  @override
  Future<ApiResponse<Query$CalculateFare>> calculateFare({
    required String customerId,
    required List<Fragment$Place> locations,
  }) async {
    return ApiResponse.loaded(
      Query$CalculateFare(
        calculateFare: Fragment$TaxiCalculateFare(
          distance: 100,
          duration: 100,
          currency: "USD",
          services: [
            Fragment$TaxiCalculateFare$services(
              id: "1",
              name: "Taxi",
              services: [
                Fragment$TaxiCalculateFare$services$services(
                  id: "1",
                  name: "Standard",
                  description: "Standard Rides",
                  personCapacity: 4,
                  costResult:
                      Fragment$TaxiCalculateFare$services$services$costResult$$FixedCost(
                        cost: 20,
                      ),
                  options: mockTaxiOrderOptions,
                  media: ImageFaker().taxiService.carYellow.toMedia,
                ),
                Fragment$TaxiCalculateFare$services$services(
                  id: "2",
                  name: "Plus",
                  description: "Plus sized for more comfort",
                  personCapacity: 4,
                  costResult:
                      Fragment$TaxiCalculateFare$services$services$costResult$$FixedCost(
                        cost: 20,
                      ),
                  options: mockTaxiOrderOptions,
                  media: ImageFaker().taxiService.carWhite.toMedia,
                ),
                Fragment$TaxiCalculateFare$services$services(
                  id: "3",
                  name: "Premium",
                  description: "Comfortable and luxurious rides",
                  personCapacity: 4,
                  costResult:
                      Fragment$TaxiCalculateFare$services$services$costResult$$FixedCost(
                        cost: 20,
                      ),
                  options: mockTaxiOrderOptions,
                  media: ImageFaker().taxiService.carPremiumBlack.toMedia,
                ),
              ],
            ),
            Fragment$TaxiCalculateFare$services(
              id: "2",
              name: "Delivery",
              services: [
                Fragment$TaxiCalculateFare$services$services(
                  id: "1",
                  name: "Standard",
                  description: "Standard Delivery without box",
                  personCapacity: 20,
                  costResult:
                      Fragment$TaxiCalculateFare$services$services$costResult$$FixedCost(
                        cost: 20,
                      ),
                  options: mockTaxiOrderOptions,
                  media: ImageFaker().taxiService.bikeYellow.toMedia,
                ),
                Fragment$TaxiCalculateFare$services$services(
                  id: "2",
                  name: "Premium",
                  description: "Premium bus service",
                  personCapacity: 20,
                  costResult:
                      Fragment$TaxiCalculateFare$services$services$costResult$$FixedCost(
                        cost: 20,
                      ),
                  options: mockTaxiOrderOptions,
                  media: ImageFaker().taxiService.bikeWithBoxYellow.toMedia,
                ),
                Fragment$TaxiCalculateFare$services$services(
                  id: "3",
                  name: "Truck",
                  description: "Truck service for heavy loads",
                  personCapacity: 20,
                  costResult:
                      Fragment$TaxiCalculateFare$services$services$costResult$$FixedCost(
                        cost: 20,
                      ),
                  options: mockTaxiOrderOptions,
                  media: ImageFaker().taxiService.pickupTruckYellow.toMedia,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<List<Fragment$DriverLocation>>> getDriverLocations({
    required Fragment$Coordinate location,
  }) async {
    return ApiResponse.loaded(
      List.generate(
        4,
        (i) => [
          mockDriverLocation1,
          mockDriverLocation2,
          mockDriverLocation3,
          mockDriverLocation4,
        ][i % 4],
      ).toList(),
    );
  }

  @override
  Future<ApiResponse<Mutation$createTaxiOrder>> createOrder({
    required Input$CreateOrderInput input,
  }) async {
    return ApiResponse.loaded(
      Mutation$createTaxiOrder(
        createTaxiOrder: Mutation$createTaxiOrder$createTaxiOrder(id: "1"),
      ),
    );
  }
}
