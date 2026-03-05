import 'package:injectable/injectable.dart';

import 'package:admin_frontend/core/datasources/graphql_datasource.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_list/data/repositories/park_spot_list_statistics_repository.dart';

@prod
@LazySingleton(as: ParkSpotListStatisticsRepository)
class ParkSpotListStatisticsRepositoryImpl
    implements ParkSpotListStatisticsRepository {
  final GraphqlDatasource graphQLDatasource;

  ParkSpotListStatisticsRepositoryImpl(this.graphQLDatasource);
}
