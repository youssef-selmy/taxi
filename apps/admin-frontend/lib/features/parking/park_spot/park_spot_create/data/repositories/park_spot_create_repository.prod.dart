import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_create/data/graphql/park_spot_create.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_create/data/repositories/park_spot_create_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ParkSpotCreateRepository)
class ParkSpotCreateRepositoryImpl implements ParkSpotCreateRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkSpotCreateRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$parkSpotDetail>> getParkSpotDetail({
    required String parkSpotId,
  }) async {
    final parkSpotOrError = await graphQLDatasource.query(
      Options$Query$parkSpot(
        variables: Variables$Query$parkSpot(id: parkSpotId),
      ),
    );
    return parkSpotOrError.mapData((r) => r.parkSpot);
  }

  @override
  Future<ApiResponse<Fragment$parkSpotDetail>> createParkSpot({
    required Input$CreateParkSpotInput input,
  }) async {
    final parkSpotOrError = await graphQLDatasource.mutate(
      Options$Mutation$createParkSpot(
        variables: Variables$Mutation$createParkSpot(input: input),
      ),
    );
    return parkSpotOrError.mapData((r) => r.createParkingSpot);
  }
}
