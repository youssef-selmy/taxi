import 'package:admin_frontend/config/env.dart';
import 'package:admin_frontend/core/graphql/fragments/token.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/dashboard/presentation/blocs/dashboard.cubit.dart';
import 'package:api_response/api_response.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/graphql/fragments/profile.fragment.graphql.dart';
import 'package:admin_frontend/core/repositories/profile_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

part 'auth.state.dart';
part 'auth.event.dart';
part 'auth.bloc.freezed.dart';

@lazySingleton
class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final ProfileRepository profileRepository;

  AuthBloc(this.profileRepository) : super(AuthState.unauthenticated()) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case AuthEvent$OnStarted():
          final profile = await profileRepository.getProfile();
          if ((profile.data?.role?.allowedApps.isNotEmpty ?? false) &&
              state.selectedAppType == null) {
            add(AuthEvent.changeAppType(profile.data!.role!.allowedApps.first));
          }
          profileRepository.getSupportedCurrencies();
          await Future.wait([
            emit.forEach(
              profileRepository.profileStream,
              onData: (data) {
                if (state.authenticated == null) {
                  return state;
                }
                return state.authenticated!.copyWith(profileResponse: data);
              },
            ),
            emit.forEach(
              profileRepository.supportedCurrenciesStream,
              onData: (data) {
                if (state.authenticated == null) {
                  return state;
                }
                return state.authenticated!.copyWith(
                  supportedCurrencies: data.data ?? [Env.defaultCurrency],
                );
              },
            ),
          ]);
          break;

        case AuthEvent$TokenRefreshed(:final accessToken):
          if (!state.isAuthenticated || state.authenticated!.isTokenExpired) {
            return;
          }
          emit(state.authenticated!.copyWith(accessToken: accessToken));
          break;

        case AuthEvent$Login(:final email, :final password):
          final jwtToken = await profileRepository.login(
            email: email,
            password: password,
          );
          emit(
            jwtToken.fold(
              (l, {failure}) {
                return AuthState.unauthenticated(loginResponse: jwtToken);
              },
              (r) {
                return AuthState.authenticated(
                  accessToken: r.accessToken,
                  refreshToken: r.refreshToken,
                  profileResponse: ApiResponse.loading(),
                  supportedCurrencies: [],
                  selectedCurrency: Env.defaultCurrency,
                  selectedAppType: null,
                );
              },
            ),
          );
          if (jwtToken.isLoaded) {
            Future.delayed(Duration(milliseconds: 500), () {
              add(AuthEvent.onStarted());
            });
          }

          break;

        case AuthEvent$Logout():
          emit(AuthState.unauthenticated());
          break;

        case AuthEvent$RefreshProfile():
          await profileRepository.getProfile();
          break;

        case AuthEvent$ChangeAppType(:final appType):
          if (!state.isAuthenticated) {
            return;
          }
          emit(state.authenticated!.copyWith(selectedAppType: appType));
          locator<DashboardBloc>().goToRoute(switch (state.selectedAppType) {
            Enum$AppType.Taxi => const TaxiOverviewRoute(),
            Enum$AppType.Shop => const ShopOverviewRoute(),
            Enum$AppType.Parking => const ParkingOverviewRoute(),
            null => PlatformOverviewShellRoute(),
            Enum$AppType.$unknown => InitialEmptyRoute(),
          });
          locator<AppRouter>().replaceAll([
            DashboardRoute(
              children: [
                switch (state.selectedAppType) {
                  Enum$AppType.Taxi => const TaxiShellRoute(),
                  Enum$AppType.Shop => const ShopShellRoute(),
                  Enum$AppType.Parking => const ParkingShellRoute(),
                  null => PlatformOverviewShellRoute(),
                  Enum$AppType.$unknown => InitialEmptyRoute(),
                },
              ],
            ),
          ], updateExistingRoutes: true);
          break;
        case AuthEvent$ChangeCurrency(:final currency):
          if (!state.isAuthenticated) {
            return;
          }
          emit(state.authenticated!.copyWith(selectedCurrency: currency));
          break;
      }
    });
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) => AuthState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AuthState state) => state.toJson();

  Future<String?> refreshToken() async {
    final accessToken = await profileRepository.refreshToken(
      refreshToken: state.refreshToken!,
    );
    if (accessToken.isError) {
      return null;
    }
    add(AuthEvent.tokenRefreshed(accessToken: accessToken.data!));
    return accessToken.data!;
  }
}
