import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_timesheet/data/graphql/driver_detail_timesheet.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_timesheet/data/repositories/driver_detail_timesheet_repository.dart';

part 'driver_detail_timesheet.state.dart';
part 'driver_detail_timesheet.bloc.freezed.dart';

class DriverDetailTimesheetBloc extends Cubit<DriverDetailTimesheetState> {
  final DriverDetailTimesheetRepository _driverDetailTimesheetRepository =
      locator<DriverDetailTimesheetRepository>();

  DriverDetailTimesheetBloc() : super(DriverDetailTimesheetState.initial());

  void onStarted(String driverId) {
    emit(DriverDetailTimesheetState.initial().copyWith(driverId: driverId));
    _fetchDriverTimesheet();
  }

  Future<void> _fetchDriverTimesheet() async {
    emit(state.copyWith(driverTimesheetState: const ApiResponse.loading()));

    var driverTimesheetOrError = await _driverDetailTimesheetRepository
        .getDriverTimesheet(
          driverId: state.driverId!,
          startDate: state.startDate,
        );

    var driverTimesheetToApiResponse = driverTimesheetOrError;

    emit(state.copyWith(driverTimesheetState: driverTimesheetToApiResponse));
  }

  void onStartDateChanged(DateTime startDate) {
    emit(state.copyWith(startDate: startDate));
    _fetchDriverTimesheet();
  }
}
