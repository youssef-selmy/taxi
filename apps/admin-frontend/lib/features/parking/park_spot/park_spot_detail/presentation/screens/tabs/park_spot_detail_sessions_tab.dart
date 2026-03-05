import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/graphql/fragments/session_info.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/blocs/park_spot_detail_sessions.cubit.dart';

class ParkSpotDetailSessionsTab extends StatelessWidget {
  final String ownerId;

  const ParkSpotDetailSessionsTab({super.key, required this.ownerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ParkSpotDetailSessionsBloc()..onStarted(ownerId: ownerId),
      child:
          BlocBuilder<ParkSpotDetailSessionsBloc, ParkSpotDetailSessionsState>(
            builder: (context, state) {
              final idSessionRecords =
                  state.loginSessionsState.data?.parkingLoginSessions
                      .map((session) => (session.id, session.sessionInfo))
                      .toList() ??
                  [];
              return idSessionRecords.view(
                context: context,
                isLoading: state.loginSessionsState.isLoading,
                onTerminate: (id) {
                  _onTerminateSession(context, id);
                },
              );
            },
          ),
    );
  }

  void _onTerminateSession(BuildContext context, String sessionId) {
    context.read<ParkSpotDetailSessionsBloc>().onTerminateSession(sessionId);
  }
}
