import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/cancel_reason.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/data/repositories/cancel_reason_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'cancel_reason_details.state.dart';
part 'cancel_reason_details.cubit.freezed.dart';

class CancelReasonDetailsBloc extends Cubit<CancelReasonDetailsState> {
  final CancelReasonRepository _cancelReasonRepository =
      locator<CancelReasonRepository>();

  CancelReasonDetailsBloc() : super(CancelReasonDetailsState.initial());

  void onStarted({required String? id}) async {
    if (id != null) {
      emit(state.copyWith(cancelReason: const ApiResponseLoading()));
      final result = await _cancelReasonRepository.getCancelReason(id: id);
      final networkState = result;
      emit(
        state.copyWith(
          cancelReason: networkState,
          name: networkState.data?.title,
          userType: networkState.data?.userType,
        ),
      );
    } else {
      emit(
        state.copyWith(
          cancelReason: const ApiResponse.loaded(null),
          name: null,
          userType: null,
        ),
      );
    }
  }

  void onSaved() {
    if (state.cancelReason.data?.id != null) {
      _updateCancelReason();
    } else {
      _createCancelReason();
    }
  }

  void _updateCancelReason() async {
    final result = await _cancelReasonRepository.updateCancelReason(
      id: state.cancelReason.data!.id,
      input: Input$OrderCancelReasonInput(
        title: state.name,
        userType: state.userType,
      ),
    );
    final networkState = result;
    emit(state.copyWith(networkStateSave: networkState));
  }

  void _createCancelReason() async {
    final result = await _cancelReasonRepository.createCancelReason(
      input: Input$OrderCancelReasonInput(
        title: state.name,
        userType: state.userType,
      ),
    );
    final networkState = result;
    emit(state.copyWith(networkStateSave: networkState));
  }

  void titleChanged(String value) {
    emit(state.copyWith(name: value));
  }

  void userTypeChanged(Enum$AnnouncementUserType? p0) {
    emit(state.copyWith(userType: p0));
  }
}
