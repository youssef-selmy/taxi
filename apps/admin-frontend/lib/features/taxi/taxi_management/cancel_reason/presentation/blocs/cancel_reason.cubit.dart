import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/cancel_reason.graphql.dart';
import 'package:admin_frontend/core/graphql/fragments/cancel_reason.graphql.extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/data/repositories/cancel_reason_repository.dart';

part 'cancel_reason.state.dart';
part 'cancel_reason.cubit.freezed.dart';

class CancelReasonBloc extends Cubit<CancelReasonState> {
  final CancelReasonRepository _cancelReasonRepository =
      locator<CancelReasonRepository>();

  CancelReasonBloc() : super(CancelReasonState.initial());

  void onStarted() {
    emit(CancelReasonState(cancelReasons: const ApiResponse.loading()));
    _fetchCancelReasons();
  }

  void refresh() {
    _fetchCancelReasons();
  }

  void _fetchCancelReasons() async {
    final cancelReasons = await _cancelReasonRepository.getCancelReasons();
    final networkState = cancelReasons;
    emit(state.copyWith(cancelReasons: networkState));
  }
}
