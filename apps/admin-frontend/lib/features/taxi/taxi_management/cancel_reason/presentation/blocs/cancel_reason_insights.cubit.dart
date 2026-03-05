import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/data/graphql/cancel_reason_insights.graphql.dart';
import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/data/repositories/cancel_reason_insights_repository.dart';

part 'cancel_reason_insights.state.dart';
part 'cancel_reason_insights.cubit.freezed.dart';

class CancelReasonInsightsBloc extends Cubit<CancelReasonInsightsState> {
  final CancelReasonInsightsRepository _cancelReasonInsightsRepository =
      locator<CancelReasonInsightsRepository>();

  CancelReasonInsightsBloc() : super(CancelReasonInsightsState.initial());

  void onStarted() {
    _fetchCancelReasonInsights();
  }

  void _fetchCancelReasonInsights() async {
    emit(state.copyWith(insights: const ApiResponse.loading()));
    final result = await _cancelReasonInsightsRepository
        .getCancelReasonInsights();
    final networkState = result;
    emit(state.copyWith(insights: networkState));
  }
}
