import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/leaderboard/leaderboard.dart';
import 'package:admin_frontend/features/shop/shop_overview/presentation/blocs/shop_overview.bloc.dart';

class ShopOverviewTopSpendingCustomers extends StatelessWidget {
  const ShopOverviewTopSpendingCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopOverviewBloc, ShopOverviewState>(
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
