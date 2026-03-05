import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_repository.dart';

part 'park_spot_detail_feedbacks.state.dart';
part 'park_spot_detail_feedbacks.cubit.freezed.dart';

class ParkSpotDetailFeedbacksBloc extends Cubit<ParkSpotDetailFeedbacksState> {
  final ParkSpotDetailRepository _parkSpotDetailRepository =
      locator<ParkSpotDetailRepository>();

  ParkSpotDetailFeedbacksBloc() : super(ParkSpotDetailFeedbacksState());

  void onStarted({required String parkSpotId}) {
    emit(state.copyWith(parkSpotId: parkSpotId));
    _fetchParkSpotDetailFeedbacks();
  }

  void _fetchParkSpotDetailFeedbacks() async {
    emit(state.copyWith(parkSpotFeedbacksState: const ApiResponse.loading()));
    final parkSpotDetailFeedbacksOrError = await _parkSpotDetailRepository
        .getParkSpotFeedbacks(parkSpotId: state.parkSpotId!);
    final parkSpotDetailFeedbacksState = parkSpotDetailFeedbacksOrError;
    emit(state.copyWith(parkSpotFeedbacksState: parkSpotDetailFeedbacksState));
  }
}
