import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/filled_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';

@RoutePage()
class ConfigErrorStateScreen extends StatelessWidget {
  final String? error;

  const ConfigErrorStateScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          color: context.colors.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              Text(
                context.tr.configError,
                style: context.textTheme.headlineMedium,
              ),
              Text(
                context.tr.networkErrorMessage,
                style: context.textTheme.bodyMedium,
              ),
              if (error != null)
                Text(
                  "${context.tr.error}: $error",
                  style: context.textTheme.bodyMedium,
                ),
              AppFilledButton(
                onPressed: () {
                  final configState = context.read<ConfigBloc>().state;
                  if (configState.isAuthenticatedUnconfigured) {
                    context.router.replaceAll([ConfigurerRoute()]);
                  } else if (configState.isUnauthenticated) {
                    context.router.replaceAll([AuthRoute()]);
                  }
                },
                text: context.tr.redirectToConfiguration,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
