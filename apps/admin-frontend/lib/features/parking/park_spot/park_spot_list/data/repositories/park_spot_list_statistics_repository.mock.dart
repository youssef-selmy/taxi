import 'package:injectable/injectable.dart';

import 'package:admin_frontend/features/parking/park_spot/park_spot_list/data/repositories/park_spot_list_statistics_repository.dart';

@dev
@LazySingleton(as: ParkSpotListStatisticsRepository)
class ParkSpotListStatisticsRepositoryMock
    implements ParkSpotListStatisticsRepository {}
