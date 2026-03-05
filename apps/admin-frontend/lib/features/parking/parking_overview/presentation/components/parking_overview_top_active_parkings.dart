import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/leaderboard/leaderboard.dart';
import 'package:admin_frontend/features/parking/parking_overview/presentation/blocs/parking_overview.bloc.dart';

class ParkingOverviewTopActiveParkings extends StatelessWidget {
  const ParkingOverviewTopActiveParkings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParkingOverviewBloc, ParkingOverviewState>(
      builder: (context, state) {
        return Leaderboard(
          items: state.topEarningParkingsState.data ?? [],
          mode: LeaderboardMode.totalOrders,
          title: context.tr.topActiveParkings,
          subtitle: context.tr.top10ActiveParkings,
        );
      },
    );
  }
}
