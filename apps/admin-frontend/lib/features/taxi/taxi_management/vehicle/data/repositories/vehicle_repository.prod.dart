import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/vehicle.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/vehicle/data/graphql/vehicle.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/vehicle/data/repositories/vehicle_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: VehicleRepository)
class VehicleRepositoryImpl implements VehicleRepository {
  final GraphqlDatasource graphQLDatasource;

  VehicleRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$vehicleColors>> getVehicleColors({
    required Input$OffsetPaging? paging,
    required Input$CarColorFilter filter,
    required List<Input$CarColorSort> sort,
  }) async {
    final colors = await graphQLDatasource.query(
      Options$Query$vehicleColors(
        variables: Variables$Query$vehicleColors(
          sorting: sort,
          filter: filter,
          paging: paging,
        ),
      ),
    );
    return colors;
  }

  @override
  Future<ApiResponse<Query$vehicleModels>> getVehicleModels({
    required Input$OffsetPaging? paging,
    required Input$CarModelFilter filter,
    required List<Input$CarModelSort> sort,
  }) async {
    final models = await graphQLDatasource.query(
      Options$Query$vehicleModels(
        variables: Variables$Query$vehicleModels(
          sorting: sort,
          paging: paging,
          filter: filter,
        ),
      ),
    );
    return models;
  }

  @override
  Future<ApiResponse<Fragment$vehicleColor>> createVehicleColor({
    required Input$CarColorInput input,
  }) async {
    final color = await graphQLDatasource.mutate(
      Options$Mutation$createVehicleColor(
        variables: Variables$Mutation$createVehicleColor(input: input),
      ),
    );
    return color.mapData((r) => r.createVehicleColor);
  }

  @override
  Future<ApiResponse<Fragment$vehicleModel>> createVehicleModel({
    required Input$CarModelInput input,
  }) async {
    final model = await graphQLDatasource.mutate(
      Options$Mutation$createVehicleModel(
        variables: Variables$Mutation$createVehicleModel(input: input),
      ),
    );
    return model.mapData((r) => r.createVehicleModel);
  }

  @override
  Future<ApiResponse<bool>> deleteVehicleColor({required String id}) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$deleteVehicleColor(
        variables: Variables$Mutation$deleteVehicleColor(id: id),
      ),
    );
    return result.mapData((r) => true);
  }

  @override
  Future<ApiResponse<bool>> deleteVehicleModel({required String id}) async {
    final result = await graphQLDatasource.mutate(
      Options$Mutation$deleteVehicleModel(
        variables: Variables$Mutation$deleteVehicleModel(id: id),
      ),
    );
    return result.mapData((r) => true);
  }

  @override
  Future<ApiResponse<Fragment$vehicleColor>> getVehicleColor({
    required String id,
  }) async {
    final color = await graphQLDatasource.query(
      Options$Query$vehicleColor(
        variables: Variables$Query$vehicleColor(id: id),
      ),
    );
    return color.mapData((r) => r.vehicleColor);
  }

  @override
  Future<ApiResponse<Fragment$vehicleModel>> getVehicleModel({
    required String id,
  }) async {
    final model = await graphQLDatasource.query(
      Options$Query$vehicleModel(
        variables: Variables$Query$vehicleModel(id: id),
      ),
    );
    return model.mapData((r) => r.vehicleModel);
  }

  @override
  Future<ApiResponse<Fragment$vehicleColor>> updateVehicleColor({
    required String id,
    required Input$CarColorInput input,
  }) async {
    final color = await graphQLDatasource.mutate(
      Options$Mutation$updateVehicleColor(
        variables: Variables$Mutation$updateVehicleColor(id: id, input: input),
      ),
    );
    return color.mapData((r) => r.updateVehicleColor);
  }

  @override
  Future<ApiResponse<Fragment$vehicleModel>> updateVehicleModel({
    required String id,
    required Input$CarModelInput input,
  }) async {
    final model = await graphQLDatasource.mutate(
      Options$Mutation$updateVehicleModel(
        variables: Variables$Mutation$updateVehicleModel(id: id, input: input),
      ),
    );
    return model.mapData((r) => r.updateVehicleModel);
  }
}
