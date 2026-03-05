import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_timesheet/data/graphql/driver_detail_timesheet.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_timesheet/data/repositories/driver_detail_timesheet_repository.dart';

@prod
@LazySingleton(as: DriverDetailTimesheetRepository)
class DriverDetailTimesheetRepositoryImpl
    implements DriverDetailTimesheetRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverDetailTimesheetRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$driverTimesheet>> getDriverTimesheet({
    required String driverId,
    required DateTime startDate,
  }) async {
    final getDriverTimesheetOrError = await graphQLDatasource.query(
      Options$Query$driverTimesheet(
        variables: Variables$Query$driverTimesheet(
          id: driverId,
          startTime: startDate,
          endTime: startDate.add(const Duration(days: 7)),
        ),
      ),
    );
    return getDriverTimesheetOrError;
  }
}
