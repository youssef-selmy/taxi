import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/driver.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/vehicle.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/data/graphql/driver_detail.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/data/repositories/driver_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: DriverDetailRepository)
class DriverDetailRepositoryMock implements DriverDetailRepository {
  @override
  Future<ApiResponse<Query$driverDetail>> getDriverDetail({
    required String driverId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$driverDetail(
        driver: mockDriverDetail1,
        carColors: Query$driverDetail$carColors(nodes: mockVehicleColors),
        carModels: Query$driverDetail$carModels(nodes: mockVehicleModels),
        fleets: Query$driverDetail$fleets(nodes: mockFleetList),
        serviceCategories: mockTaxiPricingCategories,
      ),
    );
  }

  @override
  Future<ApiResponse<Mutation$updateDriver>> updateDriver({
    required Input$UpdateOneDriverInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$updateDriver(updateOneDriver: mockDriverDetail1),
    );
  }

  @override
  Future<ApiResponse<Mutation$updateDriverService>> updateDriverService({
    required Input$SetActiveServicesOnDriverInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$updateDriverService(setActivatedServicesOnDriver: true),
    );
  }

  @override
  Future<ApiResponse<Mutation$updateDriverStatusDetail>> updateDriverStatus({
    required String id,
    required Enum$DriverStatus status,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$updateDriverStatusDetail(updateDriverStatus: mockDriverDetail1),
    );
  }
}
