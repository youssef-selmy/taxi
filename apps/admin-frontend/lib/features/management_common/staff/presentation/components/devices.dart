import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/graphql/fragments/session_info.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/management_common/staff/presentation/blocs/staff_session.cubit.dart';

class StaffDetailsDevices extends StatelessWidget {
  const StaffDetailsDevices({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StaffSessionBloc()..onStarted(),
      child: BlocBuilder<StaffSessionBloc, StaffSessionState>(
        builder: (context, state) {
          final idSessionRecords =
              state.staffSessionList.data
                  ?.map((session) => (session.id, session.sessionInfo))
                  .toList() ??
              [];
          return SizedBox(
            height: 600,
            child: SingleChildScrollView(
              child: idSessionRecords.view(
                context: context,
                isLoading: state.staffSessionList.isLoading,
                onTerminate: (sessionId) {
                  context.read<StaffSessionBloc>().onTerminateSession(
                    sessionId,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
