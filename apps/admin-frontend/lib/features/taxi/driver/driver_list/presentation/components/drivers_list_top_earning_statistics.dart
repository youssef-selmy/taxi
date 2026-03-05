import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/leaderboard/leaderboard.dart';
import 'package:admin_frontend/core/graphql/fragments/leaderboard_item.mock.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/blocs/driver_list.bloc.dart';

class DriversListTopEarningStatistics extends StatelessWidget {
  const DriversListTopEarningStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverListBloc, DriverListState>(
      builder: (context, state) {
        final drivers = state.topDriversWithEarningsState.isLoading
            ? mockLeaderboardItems
            : state.topDriversWithEarningsState.data ?? [];
        return SizedBox(
          height: 368,
          child: Leaderboard(
            items: drivers,
            mode: LeaderboardMode.totalSpendingOrEarning,
            title: context.tr.top10EarningDriver,
            subtitle: context.tr.theHighestEarningDrivers,
          ),
        );
      },
    );
  }
}
