import 'package:api_response/api_response.dart';

import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_timesheet/data/graphql/driver_detail_timesheet.graphql.dart';

abstract class DriverDetailTimesheetRepository {
  Future<ApiResponse<Query$driverTimesheet>> getDriverTimesheet({
    required String driverId,
    required DateTime startDate,
  });
}
