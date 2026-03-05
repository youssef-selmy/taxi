import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_password/data/repositories/driver_detail_password_repository.dart';

part 'driver_detail_password.state.dart';
part 'driver_detail_password.bloc.freezed.dart';

class DriverDetailPasswordBloc extends Cubit<DriverDetailPasswordState> {
  final DriverDetailPasswordRepository _driverDetailPasswordRepository =
      locator<DriverDetailPasswordRepository>();

  DriverDetailPasswordBloc() : super(const DriverDetailPasswordState());

  void onStarted(String driverId) {
    emit(state.copyWith(driverId: driverId));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void onConfirmPasswordChanged(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void onUpdatePassword() async {
    emit(state.copyWith(updatePasswordState: ApiResponse.loading()));
    final updatePasswordOrError = await _driverDetailPasswordRepository
        .updatePassword(driverId: state.driverId!, password: state.password!);
    final updatePasswordState = updatePasswordOrError;
    emit(state.copyWith(updatePasswordState: updatePasswordState));
  }
}
