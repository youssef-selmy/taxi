import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/graphql/fragments/session_info.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/blocs/fleet_staff_session.cubit.dart';

class StaffDetailsDevices extends StatelessWidget {
  const StaffDetailsDevices({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FleetStaffSessionBloc()..onStarted(),
      child: BlocBuilder<FleetStaffSessionBloc, FleetStaffSessionState>(
        builder: (context, FleetStaffSessionState state) {
          final idSessionRecords =
              state.fleetStaffSession.data?.fleetStaffSessions
                  .map((session) => (session.id, session.sessionInfo))
                  .toList() ??
              [];
          return idSessionRecords.view(
            context: context,
            isLoading: state.fleetStaffSession.isLoading,
            onTerminate: context
                .read<FleetStaffSessionBloc>()
                .onTerminateSession,
          );
        },
      ),
    );
  }
}
