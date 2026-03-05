import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail_update_password.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_update_password_repository.dart';

@prod
@LazySingleton(as: ParkSpotDetailUpdatePasswordRepository)
class ParkSpotDetailUpdatePasswordRepositoryImpl
    implements ParkSpotDetailUpdatePasswordRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkSpotDetailUpdatePasswordRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<void>> updatePassword({
    required String ownerId,
    required String password,
  }) async {
    final updateOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateParkingAppPassword(
        variables: Variables$Mutation$updateParkingAppPassword(
          ownerId: ownerId,
          password: password,
        ),
      ),
    );
    return updateOrError;
  }
}
