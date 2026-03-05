import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/leaderboard/leaderboard.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/presentation/blocs/taxi_overview.bloc.dart';

class TaxiOverviewTopSpendingCustomers extends StatelessWidget {
  const TaxiOverviewTopSpendingCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaxiOverviewBloc, TaxiOverviewState>(
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
