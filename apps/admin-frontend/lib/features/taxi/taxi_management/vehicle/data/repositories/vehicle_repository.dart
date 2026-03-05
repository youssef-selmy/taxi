import 'package:api_response/api_response.dart';

import 'package:admin_frontend/core/graphql/fragments/vehicle.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/vehicle/data/graphql/vehicle.graphql.dart';
import 'package:admin_frontend/schema.graphql.dart';

abstract class VehicleRepository {
  Future<ApiResponse<Query$vehicleColors>> getVehicleColors({
    required Input$OffsetPaging? paging,
    required Input$CarColorFilter filter,
    required List<Input$CarColorSort> sort,
  });

  Future<ApiResponse<Query$vehicleModels>> getVehicleModels({
    required Input$OffsetPaging? paging,
    required Input$CarModelFilter filter,
    required List<Input$CarModelSort> sort,
  });

  Future<ApiResponse<Fragment$vehicleModel>> getVehicleModel({
    required String id,
  });

  Future<ApiResponse<Fragment$vehicleColor>> getVehicleColor({
    required String id,
  });

  Future<ApiResponse<Fragment$vehicleModel>> createVehicleModel({
    required Input$CarModelInput input,
  });

  Future<ApiResponse<Fragment$vehicleColor>> createVehicleColor({
    required Input$CarColorInput input,
  });

  Future<ApiResponse<Fragment$vehicleModel>> updateVehicleModel({
    required String id,
    required Input$CarModelInput input,
  });

  Future<ApiResponse<Fragment$vehicleColor>> updateVehicleColor({
    required String id,
    required Input$CarColorInput input,
  });

  Future<ApiResponse<bool>> deleteVehicleModel({required String id});

  Future<ApiResponse<bool>> deleteVehicleColor({required String id});
}
