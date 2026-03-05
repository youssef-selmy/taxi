import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/leaderboard/leaderboard.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/presentation/blocs/taxi_overview.bloc.dart';

class TaxiOverviewTopActiveDrivers extends StatelessWidget {
  const TaxiOverviewTopActiveDrivers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxiOverviewBloc, TaxiOverviewState>(
      builder: (context, state) {
        return Leaderboard(
          items: state.topEarningDriversState.data ?? [],
          mode: LeaderboardMode.totalOrders,
          title: context.tr.topActiveDrivers,
          subtitle: context.tr.top10ActiveDrivers,
        );
      },
    );
  }
}
