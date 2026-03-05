import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_list/data/graphql/driver_pending_verification_list.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_pending_verification_list/data/repositories/driver_pending_verification_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: DriverPendingVerificationListRepository)
class DriverPendingVerificationListRepositoryImpl
    implements DriverPendingVerificationListRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverPendingVerificationListRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$drivers>> getDrivers({
    required Input$OffsetPaging? paging,
    required Input$DriverFilter filter,
    required List<Input$DriverSort> sorting,
  }) async {
    final getDriversListOrError = await graphQLDatasource.query(
      Options$Query$drivers(
        variables: Variables$Query$drivers(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return getDriversListOrError;
  }
}
