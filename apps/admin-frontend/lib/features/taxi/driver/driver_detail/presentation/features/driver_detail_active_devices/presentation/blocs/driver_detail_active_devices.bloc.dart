import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_active_devices/data/graphql/driver_detail_active_devices.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_active_devices/data/repositories/driver_detail_active_devices_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'driver_detail_active_devices.state.dart';
part 'driver_detail_active_devices.bloc.freezed.dart';

class DriverDetailActiveDevicesBloc
    extends Cubit<DriverDetailActiveDevicesState> {
  final DriverDetailActiveDevicesRepository
  _driverDetailActiveDevicesRepository =
      locator<DriverDetailActiveDevicesRepository>();

  DriverDetailActiveDevicesBloc()
    : super(
        // ignore: prefer_const_constructors
        DriverDetailActiveDevicesState(),
      );

  void onStarted(String driverId) {
    emit(state.copyWith(driverId: driverId));
    _fetchDriverActiveDevices();
  }

  Future<void> _fetchDriverActiveDevices() async {
    emit(state.copyWith(driverActiveDevicesState: const ApiResponse.loading()));

    var driverActiveDevicesOrError = await _driverDetailActiveDevicesRepository
        .getDriverActiveDevices(driverId: state.driverId!);

    var driverActiveDevicesToApiResponse = driverActiveDevicesOrError;

    emit(
      state.copyWith(
        driverActiveDevicesState: driverActiveDevicesToApiResponse,
      ),
    );
  }

  Future<void> deleteDriverActiveDevice(String deviceId) async {
    emit(
      state.copyWith(
        deleteDriverActiveDeviceState: const ApiResponse.loading(),
      ),
    );

    var deleteDriverActiveDeviceOrError =
        await _driverDetailActiveDevicesRepository.deleteDriverActiveDevice(
          input: Input$DeleteOneDriverSessionInput(id: deviceId),
        );

    emit(
      state.copyWith(
        deleteDriverActiveDeviceState: deleteDriverActiveDeviceOrError,
      ),
    );

    _fetchDriverActiveDevices();
  }
}
