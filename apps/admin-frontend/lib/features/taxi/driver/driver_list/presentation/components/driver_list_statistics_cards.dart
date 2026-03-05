import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/components/kpi_card/kpi_card_style_c.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/blocs/driver_list.bloc.dart';
import 'package:better_icons/better_icons.dart';

class DriverListStatisticsCards extends StatelessWidget {
  const DriverListStatisticsCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverListBloc, DriverListState>(
      builder: (context, state) {
        return LayoutGrid(
          columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr, 1.fr, 1.fr]),
          rowGap: 8,
          columnGap: 8,
          rowSizes: const [auto, auto, auto, auto],
          children: [
            KPICardStyleC(
              title: context.tr.totalTripsCompleted,
              subtitle: context.tr.totalTripsCompletedByAllDrivers,
              value: state.totalTripsCompletedCount.toString(),
              iconData: BetterIcons.clock01Filled,
            ),
            KPICardStyleC(
              title: context.tr.averageRating,
              value: '${(state.averageRatings / 20).toStringAsFixed(1)}/5',
              subtitle: context.tr.averageRatingAllDrivers,
              iconData: BetterIcons.starFilled,
            ),
            KPICardStyleC(
              title: context.tr.totalEarnings,
              subtitle: context.tr.totalEarningsAllDrivers,
              value: state.totalEarningsCount.formatCurrency(state.currency),
              iconData: BetterIcons.money03Filled,
            ),
            KPICardStyleC(
              title: context.tr.activeDrivers,
              subtitle: context.tr.totalActiveDrivers,
              value: state.activeDriversCount.toString(),
              iconData: BetterIcons.taxiFilled,
            ),
          ],
        );
      },
    );
  }
}
