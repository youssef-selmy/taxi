import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/documents/config.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/repositories/config_repository.dart';
import 'package:admin_frontend/features/auth/data/graphql/auth.graphql.dart';
import 'package:admin_frontend/features/auth/data/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

part 'auth.state.dart';
part 'auth.bloc.freezed.dart';
part 'auth.event.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = locator<AuthRepository>();
  final ConfigRepository _configRepository = locator<ConfigRepository>();

  AuthBloc() : super(AuthState()) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case AuthEventActivateServer():
          emit(
            state.copyWith(activateServerResponse: const ApiResponse.loading()),
          );
          final result = await _configRepository.updateLicense(
            purchaseCode: state.purchaseCode!,
            email: state.email!,
          );
          emit(state.copyWith(activateServerResponse: result));
          break;

        case AuthEventDisableServer(:final ip, :final purchaseCode):
          emit(
            state.copyWith(disableServerResponse: const ApiResponse.loading()),
          );
          final result = await _authRepository.disableServer(
            purchaseCode: purchaseCode,
            ip: ip,
          );
          if (result.isLoaded) {
            activateServer();
          }
          emit(
            state.copyWith(
              disableServerResponse: result.mapData(
                (data) => data.disablePreviousServer,
              ),
            ),
          );
          emit(
            state.copyWith(disableServerResponse: const ApiResponse.initial()),
          );
          break;

        case AuthEventOnLicenseKeyChanged(:final p0):
          emit(state.copyWith(purchaseCode: p0));
          break;

        case AuthEventOnEmailChanged(:final p0):
          emit(state.copyWith(email: p0));
          break;
      }
    });
  }

  void activateServer() => add(const AuthEvent.activateServer());

  void disableServer({required String purchaseCode, required String ip}) =>
      add(AuthEventDisableServer(purchaseCode: purchaseCode, ip: ip));

  void onLicenseKeyChanged(String? p0) => add(AuthEventOnLicenseKeyChanged(p0));

  void onEmailChanged(String? p0) => add(AuthEventOnEmailChanged(p0));
}
