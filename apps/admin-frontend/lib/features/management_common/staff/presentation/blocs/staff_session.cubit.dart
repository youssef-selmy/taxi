import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/staff.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/management_common/staff/data/repositories/staff_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'staff_session.state.dart';
part 'staff_session.cubit.freezed.dart';

class StaffSessionBloc extends Cubit<StaffSessionState> {
  final StaffRepository _staffRepository = locator<StaffRepository>();

  StaffSessionBloc() : super(StaffSessionState.initial());

  void onStarted() async {
    _fetchSessions();
  }

  Future<void> _fetchSessions() async {
    emit(state.copyWith(staffSessionList: const ApiResponse.loading()));
    final staffSession = await _staffRepository.getSessions(
      filter: Input$OperatorFilter(),
      sorting: [],
    );

    emit(state.copyWith(staffSessionList: staffSession));
  }

  void onTerminateSession(String sessionId) async {
    final terminateSessionOrError = await _staffRepository.terminateSession(
      id: sessionId,
    );
    if (terminateSessionOrError.isLoaded) {
      _fetchSessions();
    }
  }
}
