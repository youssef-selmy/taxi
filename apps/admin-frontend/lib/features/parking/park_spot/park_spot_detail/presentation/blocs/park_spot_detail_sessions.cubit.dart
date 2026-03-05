import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail_sessions.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_sessions_repository.dart';

part 'park_spot_detail_sessions.state.dart';
part 'park_spot_detail_sessions.cubit.freezed.dart';

class ParkSpotDetailSessionsBloc extends Cubit<ParkSpotDetailSessionsState> {
  final ParkSpotDetailSessionsRepository _parkSpotDetailSessionsRepository =
      locator<ParkSpotDetailSessionsRepository>();

  ParkSpotDetailSessionsBloc() : super(ParkSpotDetailSessionsState());

  void onStarted({required String ownerId}) {
    emit(state.copyWith(ownerId: ownerId));
    _fetchSessions();
  }

  Future<void> _fetchSessions() async {
    emit(state.copyWith(loginSessionsState: ApiResponse.loading()));
    final sessionsOrError = await _parkSpotDetailSessionsRepository.getSessions(
      ownerId: state.ownerId!,
    );
    final sessionsState = sessionsOrError;
    emit(state.copyWith(loginSessionsState: sessionsState));
  }

  void onTerminateSession(String sessionId) async {
    final terminateSessionOrError = await _parkSpotDetailSessionsRepository
        .terminateSession(sessionId: sessionId);
    if (terminateSessionOrError.isLoaded) {
      _fetchSessions();
    }
  }
}
