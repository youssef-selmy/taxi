import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/driver.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/driver_document.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/fleet.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/taxi_pricing.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/vehicle.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/data/graphql/create_new_driver.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/create_new_driver/data/repositories/create_new_driver_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: CreateNewDriverRepository)
class CreateNewDriverRepositoryMock implements CreateNewDriverRepository {
  @override
  Future<ApiResponse<Query$driverDetails>> getdriverDetails() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$driverDetails(
        carModels: Query$driverDetails$carModels(nodes: mockVehicleModels),
        fleets: Query$driverDetails$fleets(nodes: mockFleetList),
        carColors: Query$driverDetails$carColors(nodes: mockVehicleColors),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$driverDocuments>> getDriverDocuments() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$driverDocuments(driverDocuments: mockDriverDocumentList),
    );
  }

  @override
  Future<ApiResponse<Query$services>> getServices() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$services(serviceCategories: mockTaxiPricingCategories),
    );
  }

  @override
  Future<ApiResponse<Mutation$createDriver>> createDriver({
    required Input$CreateOneDriverInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$createDriver(createOneDriver: mockDriverDetail1),
    );
  }

  @override
  Future<ApiResponse<Mutation$createDriverToDriverDocument>>
  createDriverToDriverDocument({
    required Input$CreateOneDriverToDriverDocumentInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$createDriverToDriverDocument(
        createOneDriverToDriverDocument: mockDriverToDriverDocument1,
      ),
    );
  }

  @override
  Future<ApiResponse<Mutation$setEnabledServices>> setEnabledServices({
    required Input$SetActiveServicesOnDriverInput input,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Mutation$setEnabledServices(setActivatedServicesOnDriver: true),
    );
  }
}
