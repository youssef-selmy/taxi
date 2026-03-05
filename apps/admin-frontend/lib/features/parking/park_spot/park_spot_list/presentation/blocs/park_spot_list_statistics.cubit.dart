import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/features/parking/park_spot/park_spot_list/data/graphql/park_spot_list_statistics.graphql.dart';

part 'park_spot_list_statistics.state.dart';
part 'park_spot_list_statistics.cubit.freezed.dart';

class ParkSpotListStatisticsBloc extends Cubit<ParkSpotListStatisticsState> {
  // final ParkSpotListStatisticsRepository _parkSpotListStatisticsRepository = locator<ParkSpotListStatisticsRepository>();

  ParkSpotListStatisticsBloc() : super(ParkSpotListStatisticsState());

  void onStarted() {}
}
