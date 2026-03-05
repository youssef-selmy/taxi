import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';

import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/router/app_router.dart';

class ConfigGuard extends AutoRouteGuard {
@override
void onNavigation(NavigationResolver resolver, StackRouter router) {
  // ✅ OPTION C: skip license/config checks via build flag
  const skipAuth = bool.fromEnvironment('SKIP_AUTH');
  if (skipAuth) {
    resolver.next(true);
    return;
  }

  final state = locator<ConfigBloc>().state;

  switch (state.license) {
    case ApiResponseError(:final errorMessage):
      resolver.redirectUntil(
        ConfigErrorStateRoute(error: errorMessage),
      );
      break;

    case ApiResponseLoaded():
      switch (state.config) {
        case ApiResponseLoaded(:final data):
          if (data.isValid) {
            resolver.next(true);
          } else {
            resolver.redirectUntil(const ConfigurerRoute());
          }
          break;

        case ApiResponseError(:final errorMessage):
          resolver.redirectUntil(
            ConfigErrorStateRoute(error: errorMessage),
          );
          break;

        default:
          resolver.next(false);
          throw Exception('Invalid state');
      }
      break;

    default:
      resolver.next(false);
      throw Exception('Invalid state');
  }
}
}
