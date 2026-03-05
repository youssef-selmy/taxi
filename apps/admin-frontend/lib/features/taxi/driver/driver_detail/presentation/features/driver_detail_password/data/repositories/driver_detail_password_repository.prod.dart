import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_password/data/graphql/driver_detail_password.graphql.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_password/data/repositories/driver_detail_password_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: DriverDetailPasswordRepository)
class DriverDetailPasswordRepositoryImpl
    implements DriverDetailPasswordRepository {
  final GraphqlDatasource graphQLDatasource;

  DriverDetailPasswordRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<void>> updatePassword({
    required String driverId,
    required String password,
  }) async {
    var updatePasswordOrError = graphQLDatasource.mutate(
      Options$Mutation$updateDriverPassword(
        variables: Variables$Mutation$updateDriverPassword(
          input: Input$UpdateOneDriverInput(
            id: driverId,
            update: Input$UpdateDriverInput(password: password),
          ),
        ),
      ),
    );
    return updatePasswordOrError;
  }
}
