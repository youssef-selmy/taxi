import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_list/data/graphql/park_spot_list.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_list/data/repositories/park_spot_list_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ParkSpotListRepository)
class ParkSpotListRepositoryImpl implements ParkSpotListRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkSpotListRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Query$parkSpots>> getParkSpots({
    required Input$OffsetPaging? paging,
    required Input$ParkSpotFilter filter,
    required List<Input$ParkSpotSort> sorting,
  }) async {
    final parkSpotsOrError = await graphQLDatasource.query(
      Options$Query$parkSpots(
        variables: Variables$Query$parkSpots(
          paging: paging,
          filter: filter,
          sorting: sorting,
        ),
      ),
    );
    return parkSpotsOrError;
  }
}
