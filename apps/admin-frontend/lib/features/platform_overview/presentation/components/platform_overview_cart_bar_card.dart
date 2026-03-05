import 'package:admin_frontend/core/blocs/config.bloc.dart';
import 'package:admin_frontend/core/enums/app_color_scheme.enum.dart';
import 'package:admin_frontend/features/platform_overview/data/graphql/platform_overview.graphql.dart';
import 'package:admin_frontend/features/platform_overview/presentation/blocs/platform_overview.cubit.dart';
import 'package:better_design_system/molecules/charts/chart_series_data.dart';
import 'package:better_design_system/molecules/kpi_card/bar_chart_stat_card/bar_chart_stat_card.dart';
import 'package:better_design_system/theme/theme.dart';
import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PlatformOverviewCartBarCard extends StatelessWidget {
  const PlatformOverviewCartBarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(
      builder: (context, state) {
        return BlocBuilder<PlatformOverviewCubit, PlatformOverviewState>(
          builder: (context, statePlatform) {
            final List<Query$orderVolumeTimeSeries$orderVolumeTimeSeries>
            orderVolumeTimeSeries =
                statePlatform
                    .orderVolumeTimeSeries
                    .data
                    ?.orderVolumeTimeSeries ??
                [];
            return Skeletonizer(
              enabled: statePlatform.orderVolumeTimeSeries.isLoading,
              child: AppBarChartStatCard(
                title: context.tr.ordersVolume,
                chartHeight: 227,
                chartSeriesData: orderVolumeTimeSeries
                    .map(
                      (app) => ChartSeriesData(
                        name: state.appConfig(app.app).name ?? context.tr.taxi,
                        points: app.buckets
                            .map(
                              (bucket) => ChartPoint(
                                name: bucket.date,
                                value: bucket.orderCount.toDouble(),
                              ),
                            )
                            .toList(),
                        color:
                            state
                                .appConfig(app.app)
                                .color
                                ?.toBrandColor
                                .colors
                                .firstOrNull ??
                            BetterTheme.cobaltLight(false).primaryColor,
                      ),
                    )
                    .toList(),
              ),
            );
          },
        );
      },
    );
  }
}
