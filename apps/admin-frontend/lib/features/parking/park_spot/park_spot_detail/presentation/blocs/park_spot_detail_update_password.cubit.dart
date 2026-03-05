import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_update_password_repository.dart';

part 'park_spot_detail_update_password.state.dart';
part 'park_spot_detail_update_password.cubit.freezed.dart';

class ParkSpotDetailUpdatePasswordBloc
    extends Cubit<ParkSpotDetailUpdatePasswordState> {
  final ParkSpotDetailUpdatePasswordRepository
  _parkSpotDetailUpdatePasswordRepository =
      locator<ParkSpotDetailUpdatePasswordRepository>();

  ParkSpotDetailUpdatePasswordBloc()
    : super(const ParkSpotDetailUpdatePasswordState());

  void onStarted({required String ownerId}) {
    emit(state.copyWith(ownerId: ownerId));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void onConfirmPasswordChanged(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void onUpdatePassword() async {
    emit(state.copyWith(updatePasswordState: ApiResponse.loading()));
    final updatePasswordOrError = await _parkSpotDetailUpdatePasswordRepository
        .updatePassword(ownerId: state.ownerId!, password: state.password!);
    final updatePasswordState = updatePasswordOrError;
    emit(state.copyWith(updatePasswordState: updatePasswordState));
  }
}
