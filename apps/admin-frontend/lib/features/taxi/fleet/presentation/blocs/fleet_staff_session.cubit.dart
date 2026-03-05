import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/fleet/data/graphql/fleet_session.graphql.dart';
import 'package:admin_frontend/features/taxi/fleet/data/repositories/fleet_staffs_repository.dart';

part 'fleet_staff_session.state.dart';
part 'fleet_staff_session.cubit.freezed.dart';

class FleetStaffSessionBloc extends Cubit<FleetStaffSessionState> {
  final FleetStaffsRepository _fleetStaffSessionRepository =
      locator<FleetStaffsRepository>();

  FleetStaffSessionBloc() : super(FleetStaffSessionState.initial());

  void onStarted() {
    _fetchFleetStaffSessions();
  }

  Future<void> _fetchFleetStaffSessions() async {
    emit(state.copyWith(fleetStaffSession: const ApiResponse.loading()));

    final result = await _fleetStaffSessionRepository.getFleetStaffSession();

    emit(state.copyWith(fleetStaffSession: result));
  }

  Future<void> onTerminateSession(String id) async {
    final terminateOrError = await _fleetStaffSessionRepository
        .terminateSession(sessionId: id);
    if (terminateOrError.isLoaded) {
      _fetchFleetStaffSessions();
    }
  }
}
