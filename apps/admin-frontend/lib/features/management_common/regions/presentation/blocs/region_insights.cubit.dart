import 'package:api_response/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:admin_frontend/core/graphql/fragments/insights.fragment.graphql.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/management_common/regions/data/repositories/regions_repository.dart';

part 'region_insights.state.dart';
part 'region_insights.cubit.freezed.dart';

class RegionInsightsBloc extends Cubit<RegionInsightsState> {
  final RegionsRepository _regionsRepository = locator<RegionsRepository>();

  RegionInsightsBloc()
    : super(
        RegionInsightsState(regionPopularityChart: const ApiResponse.initial()),
      );

  void onStarted() async {
    emit(state.copyWith(regionPopularityChart: const ApiResponse.loading()));
    final result = await _regionsRepository.getRegionPopularity();
    emit(state.copyWith(regionPopularityChart: result));
  }
}
