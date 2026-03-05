import 'package:admin_frontend/core/graphql/fragments/driver_shift_rule.fragment.graphql.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/timesheet.mock.dart';
import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_timesheet/data/graphql/driver_detail_timesheet.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_timesheet/data/repositories/driver_detail_timesheet_repository.dart';

@dev
@LazySingleton(as: DriverDetailTimesheetRepository)
class DriverDetailTimesheetRepositoryMock
    implements DriverDetailTimesheetRepository {
  @override
  Future<ApiResponse<Query$driverTimesheet>> getDriverTimesheet({
    required String driverId,
    required DateTime startDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ApiResponse.loaded(
      Query$driverTimesheet(
        driverTimesheet: mockTimesheet,
        driverShiftRules: mockDriverShiftRuleList,
      ),
    );
  }
}
