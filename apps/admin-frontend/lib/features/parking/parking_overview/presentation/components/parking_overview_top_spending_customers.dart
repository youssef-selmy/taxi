import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/leaderboard/leaderboard.dart';
import 'package:admin_frontend/features/parking/parking_overview/presentation/blocs/parking_overview.bloc.dart';

class ParkingOverviewTopSpendingCustomers extends StatelessWidget {
  const ParkingOverviewTopSpendingCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkingOverviewBloc, ParkingOverviewState>(
      builder: (context, state) {
        return Leaderboard(
          items: state.topSpendingCustomersState.data ?? [],
          mode: LeaderboardMode.totalSpendingOrEarning,
          title: context.tr.topSpendingCustomers,
          subtitle: context.tr.top10SpendingCustomers,
        );
      },
    );
  }
}
