import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/graphql/fragments/session_info.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/settings/features/settings_sessions/presentation/blocs/settings_sessions.bloc.dart';

@RoutePage()
class SettingsSessionsScreen extends StatelessWidget {
  const SettingsSessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsSessionsBloc()..onStarted(),
      child: BlocBuilder<SettingsSessionsBloc, SettingsSessionsState>(
        builder: (context, state) {
          final idSessionRecords =
              state.sessionsState.data?.currentUserSessions
                  .map((session) => (session.id, session.sessionInfo))
                  .toList() ??
              [];
          return SingleChildScrollView(
            child: idSessionRecords.view(
              context: context,
              isLoading: state.sessionsState.isLoading,
              onTerminate: (sessionId) {
                context.read<SettingsSessionsBloc>().onTerminateSession(
                  sessionId,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
