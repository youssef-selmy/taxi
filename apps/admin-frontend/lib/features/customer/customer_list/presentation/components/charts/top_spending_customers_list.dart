import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/leaderboard/leaderboard.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/blocs/customers_statistics.cubit.dart';
import 'package:better_localization/localizations.dart';

class TopSpendingCustomersList extends StatelessWidget {
  const TopSpendingCustomersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomersStatisticsBloc, CustomersStatisticsState>(
      builder: (context, state) {
        final customers = state.stats.data?.topSpendingCustomers ?? [];
        return Leaderboard(
          items: customers,
          mode: LeaderboardMode.totalSpendingOrEarning,
          title: context.tr.topSpendingCustomers,
          subtitle: context.tr.top10SpendingCustomers,
        );
      },
    );
  }
}
