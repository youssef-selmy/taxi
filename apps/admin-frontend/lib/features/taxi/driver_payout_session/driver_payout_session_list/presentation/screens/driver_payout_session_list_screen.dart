import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:intl/intl.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/molecules/dropdown_currency/droopdown_currency.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_list/presentation/blocs/driver_payout_session_list.cubit.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_list/presentation/components/driver_payout_session_list_new_payout_session_card.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_list/presentation/components/driver_payout_session_list_pending_sessions_card.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_list/presentation/components/driver_payout_session_list_sessions_list.dart';
import 'package:admin_frontend/features/taxi/driver_payout_session/driver_payout_session_list/presentation/components/driver_payout_session_list_transactions_records.dart';

@RoutePage()
class DriverPayoutSessionListScreen extends StatelessWidget {
  const DriverPayoutSessionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DriverPayoutSessionListBloc()
            ..onStarted(currency: locator<AuthBloc>().state.selectedCurrency),
      child: SingleChildScrollView(
        child: Container(
          color: context.colors.surface,
          margin: context.pagePadding.copyWith(bottom: 0),
          child: Column(
            children: [
              PageHeader(
                title: context.tr.driverPayouts,
                subtitle: DateFormat('dd MMM, yyyy').format(DateTime.now()),
                actions: const [
                  SizedBox(
                    width: 170,
                    child: AppDroopdownCurrency(
                      isCompact: true,
                      showTitle: false,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              LayoutGrid(
                columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr]),
                rowSizes: context.responsive([220.px, 220.px], lg: [220.px]),
                rowGap: 16,
                columnGap: 16,
                children: const [
                  DriverPayoutSessionListNewPayoutSessionCard(),
                  // DriverPayoutSessionListScheduledPayoutsCard(),
                  DriverPayoutSessionListPendingSessionsCard(),
                ],
              ),
              const SizedBox(height: 16),
              const SizedBox(
                height: 450,
                child: DriverPayoutSessionListSessionsList(),
              ),
              const SizedBox(height: 16),
              const SizedBox(
                height: 450,
                child: DriverPayoutSessionListTransactionsRecords(),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
