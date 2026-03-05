import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/vehicle.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/vehicle.graphql.mock.dart';
import 'package:admin_frontend/features/taxi/taxi_management/vehicle/data/graphql/vehicle.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/vehicle/data/repositories/vehicle_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@dev
@LazySingleton(as: VehicleRepository)
class VehicleRepositoryMock implements VehicleRepository {
  @override
  Future<ApiResponse<Query$vehicleColors>> getVehicleColors({
    required Input$OffsetPaging? paging,
    required Input$CarColorFilter filter,
    required List<Input$CarColorSort> sort,
  }) async {
    return ApiResponse.loaded(
      Query$vehicleColors(
        vehicleColors: Query$vehicleColors$vehicleColors(
          nodes: mockVehicleColors,
          pageInfo: mockPageInfo,
          totalCount: mockVehicleColors.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Query$vehicleModels>> getVehicleModels({
    required Input$OffsetPaging? paging,
    required Input$CarModelFilter filter,
    required List<Input$CarModelSort> sort,
  }) async {
    return ApiResponse.loaded(
      Query$vehicleModels(
        vehicleModels: Query$vehicleModels$vehicleModels(
          nodes: mockVehicleModels,
          pageInfo: mockPageInfo,
          totalCount: mockVehicleModels.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<Fragment$vehicleColor>> createVehicleColor({
    required Input$CarColorInput input,
  }) async {
    return ApiResponse.loaded(mockVehicleColor1);
  }

  @override
  Future<ApiResponse<Fragment$vehicleModel>> createVehicleModel({
    required Input$CarModelInput input,
  }) async {
    return ApiResponse.loaded(mockVehicleModel1);
  }

  @override
  Future<ApiResponse<bool>> deleteVehicleColor({required String id}) async {
    return const ApiResponse.loaded(true);
  }

  @override
  Future<ApiResponse<bool>> deleteVehicleModel({required String id}) async {
    return const ApiResponse.loaded(true);
  }

  @override
  Future<ApiResponse<Fragment$vehicleColor>> getVehicleColor({
    required String id,
  }) async {
    return ApiResponse.loaded(mockVehicleColor1);
  }

  @override
  Future<ApiResponse<Fragment$vehicleModel>> getVehicleModel({
    required String id,
  }) async {
    return ApiResponse.loaded(mockVehicleModel1);
  }

  @override
  Future<ApiResponse<Fragment$vehicleColor>> updateVehicleColor({
    required String id,
    required Input$CarColorInput input,
  }) async {
    return ApiResponse.loaded(mockVehicleColor1);
  }

  @override
  Future<ApiResponse<Fragment$vehicleModel>> updateVehicleModel({
    required String id,
    required Input$CarModelInput input,
  }) async {
    return ApiResponse.loaded(mockVehicleModel1);
  }
}
