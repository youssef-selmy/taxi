import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/chart_card/chart_card.dart';
import 'package:admin_frontend/core/components/charts/bar_chart_thin.dart';
import 'package:admin_frontend/core/graphql/fragments/insights.extensions.dart';
import 'package:admin_frontend/features/management_common/regions/data/repositories/regions_repository.mock.dart';
import 'package:admin_frontend/features/management_common/regions/presentation/blocs/region_insights.cubit.dart';

class RegionsInsights extends StatelessWidget {
  const RegionsInsights({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegionInsightsBloc()..onStarted(),
      child: BlocBuilder<RegionInsightsBloc, RegionInsightsState>(
        builder: (context, state) {
          return Skeletonizer(
            enabled: state.regionPopularityChart.isLoading,
            child: ChartCard(
              title: context.tr.regionsPopularity,
              subtitle: context.tr.topRegionsByPopularity,
              child: Container(
                height: 200,
                padding: const EdgeInsets.all(16),
                child: BarChartThin(
                  data:
                      (state.regionPopularityChart.data ??
                              mockRegionPopularityChart)
                          .toChartSeriesData(),
                  bottomTitleBuilder: (data) => data.name,
                  leftTitleBuilder: (value) => value.toStringAsFixed(0),
                  leftReservedSize: 50,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
