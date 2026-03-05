part of 'driver_detail_timesheet.bloc.dart';

@freezed
sealed class DriverDetailTimesheetState with _$DriverDetailTimesheetState {
  const factory DriverDetailTimesheetState({
    @Default(ApiResponse.initial())
    ApiResponse<Query$driverTimesheet> driverTimesheetState,
    String? driverId,
    required DateTime startDate,
  }) = _DriverDetailTimesheetState;

  const DriverDetailTimesheetState._();

  factory DriverDetailTimesheetState.initial() => DriverDetailTimesheetState(
    startDate:
        // start of current week
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)),
  );
}
