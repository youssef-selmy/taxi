import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/graphql/fragments/session_info.fragment.graphql.extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_active_devices/presentation/blocs/driver_detail_active_devices.bloc.dart';

class DriverDetailActiveDevicesScreen extends StatelessWidget {
  const DriverDetailActiveDevicesScreen({super.key, required this.driverId});
  final String driverId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverDetailActiveDevicesBloc()..onStarted(driverId),
      child:
          BlocBuilder<
            DriverDetailActiveDevicesBloc,
            DriverDetailActiveDevicesState
          >(
            builder: (context, state) {
              final idSessionRecords =
                  state.driverActiveDevicesState.data?.driverActiveDevices
                      .map((session) => (session.id, session.sessionInfo))
                      .toList() ??
                  [];
              return idSessionRecords.view(
                context: context,
                isLoading: state.driverActiveDevicesState.isLoading,
                onTerminate: context
                    .read<DriverDetailActiveDevicesBloc>()
                    .deleteDriverActiveDevice,
              );
            },
          ),
    );
  }
}
