import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/customer_session.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/customer/customer_detail/data/repositories/sessions_repository.dart';

part 'sessions.state.dart';
part 'sessions.cubit.freezed.dart';

class SessionsBloc extends Cubit<SessionsState> {
  final SessionsRepository _sessionsRepository = locator<SessionsRepository>();

  SessionsBloc()
    : super(SessionsState(networkState: const ApiResponse.initial()));

  void onStarted({required String customerId}) {
    emit(state.copyWith(customerId: customerId));
    _fetchSessions();
  }

  Future<void> _fetchSessions() async {
    emit(state.copyWith(networkState: const ApiResponse.loading()));
    final result = await _sessionsRepository.getCustomerSessions(
      state.customerId!,
    );
    emit(state.copyWith(networkState: result));
  }

  Future<void> onTerminate(String sessionId) async {
    emit(state.copyWith(networkState: const ApiResponse.loading()));
    final deleteOrError = await _sessionsRepository.terminateSession(
      sessionId: sessionId,
    );
    if (deleteOrError.isLoaded) {
      _fetchSessions();
    }
  }
}
