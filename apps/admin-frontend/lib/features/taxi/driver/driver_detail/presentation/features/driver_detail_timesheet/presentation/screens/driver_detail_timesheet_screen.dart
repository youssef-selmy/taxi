import 'package:admin_frontend/core/graphql/fragments/driver_shift_rule.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/timesheet.extensions.dart';
import 'package:admin_frontend/schema.graphql.dart';
import 'package:better_design_system/molecules/time_sheet/time_sheet.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_timesheet/presentation/blocs/driver_detail_timesheet.bloc.dart';

class DriverDetailTimesheetScreen extends StatelessWidget {
  const DriverDetailTimesheetScreen({super.key, required this.driverId});
  final String driverId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverDetailTimesheetBloc()..onStarted(driverId),
      child: BlocBuilder<DriverDetailTimesheetBloc, DriverDetailTimesheetState>(
        builder: (context, state) {
          return AppTimeSheet(
            isLoading: state.driverTimesheetState.isLoading,
            onWeekChanged: (startDate, endDate) {
              context.read<DriverDetailTimesheetBloc>().onStartDateChanged(
                startDate,
              );
            },
            currentStartDateTime: state.startDate,
            entries:
                state.driverTimesheetState.data?.driverTimesheet.toEntries() ??
                [],
            maxWeeklySeconds:
                state.driverTimesheetState.data?.driverShiftRules
                    .maxSecondsPerFrequency(Enum$TimeFrequency.Weekly) ??
                0,
            maxDailySeconds:
                state.driverTimesheetState.data?.driverShiftRules
                    .maxSecondsPerFrequency(Enum$TimeFrequency.Daily) ??
                0,
          );
        },
      ),
    );
  }
}
