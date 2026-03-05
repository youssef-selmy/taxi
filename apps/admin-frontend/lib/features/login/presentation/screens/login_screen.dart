import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/login/presentation/blocs/login.cubit.dart';
import 'package:admin_frontend/features/login/presentation/screens/login_screen.desktop.dart';
import 'package:admin_frontend/features/login/presentation/screens/login_screen.mobile.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state.isAuthenticated) {
              TextInput.finishAutofillContext();
              locator<AuthBloc>().add(AuthEvent$OnStarted());
              context.router.replaceAll([const DashboardRoute()]);
            }
            if (state.unauthenticated?.loginResponse.errorMessage != null) {
              context.showToast(
                state.unauthenticated!.loginResponse.errorMessage!,
              );
            }
          },
          child: context.responsive(
            const LoginScreenMobile(),
            lg: const LoginScreenDesktop(),
          ),
        ),
      ),
    );
  }
}
