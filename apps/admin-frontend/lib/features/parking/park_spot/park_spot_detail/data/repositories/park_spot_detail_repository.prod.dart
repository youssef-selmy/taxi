import 'package:api_response/api_response.dart';
import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/core/graphql/fragments/parking.fragment.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/graphql/park_spot_detail.graphql.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/data/repositories/park_spot_detail_repository.dart';
import 'package:admin_frontend/schema.graphql.dart';

@prod
@LazySingleton(as: ParkSpotDetailRepository)
class ParkSpotDetailRepositoryImpl implements ParkSpotDetailRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkSpotDetailRepositoryImpl(this.graphQLDatasource);

  @override
  Future<ApiResponse<Fragment$parkSpotDetail>> getParkSpotDetail({
    required String parkSpotId,
  }) async {
    final parkSpotOrError = await graphQLDatasource.query(
      Options$Query$parkSpotDetail(
        variables: Variables$Query$parkSpotDetail(id: parkSpotId),
      ),
    );
    return parkSpotOrError.mapData((r) => r.parkSpot);
  }

  @override
  Future<ApiResponse<Query$parkSpotFeedbacks>> getParkSpotFeedbacks({
    required String parkSpotId,
  }) async {
    final feedbacksOrError = await graphQLDatasource.query(
      Options$Query$parkSpotFeedbacks(
        variables: Variables$Query$parkSpotFeedbacks(parkSpotId: parkSpotId),
      ),
    );
    return feedbacksOrError;
  }

  @override
  Future<ApiResponse<Fragment$parkSpotDetail>> updateParkSpot({
    required String parkSpotId,
    required Input$UpdateParkSpotInput input,
  }) async {
    final parkSpotOrError = await graphQLDatasource.mutate(
      Options$Mutation$updateParkSpot(
        variables: Variables$Mutation$updateParkSpot(
          id: parkSpotId,
          update: input,
        ),
      ),
    );
    return parkSpotOrError.mapData((r) => r.updateOneParkSpot);
  }
}
