import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:auto_route/auto_route.dart';

import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/router/app_router.dart';

class DisableConfigGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final state = locator<ConfigBloc>().state;
    final authState = locator<AuthBloc>().state;
    if (state.isDone) {
      if (authState.isAuthenticated) {
        resolver.redirectUntil(const DashboardRoute());
      } else {
        resolver.redirectUntil(const LoginRoute());
      }
    } else {
      resolver.next(true);
    }
  }
}
