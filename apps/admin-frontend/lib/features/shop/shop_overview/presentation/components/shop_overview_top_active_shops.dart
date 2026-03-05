import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/leaderboard/leaderboard.dart';
import 'package:admin_frontend/features/shop/shop_overview/presentation/blocs/shop_overview.bloc.dart';

class ShopOverviewTopActiveShops extends StatelessWidget {
  const ShopOverviewTopActiveShops({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopOverviewBloc, ShopOverviewState>(
      builder: (context, state) {
        return Leaderboard(
          items: state.topEarningShopsState.data ?? [],
          mode: LeaderboardMode.totalOrders,
          title: context.tr.topActiveShops,
          subtitle: context.tr.top10ActiveShops,
        );
      },
    );
  }
}
