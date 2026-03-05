import 'package:admin_frontend/core/components/dashboard_header.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/blocs/auth.bloc.dart';
import 'package:admin_frontend/core/components/atoms/copyright_notice/copyright_notice.dart';
import 'package:admin_frontend/core/components/molecules/dropdown_currency/droopdown_currency.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/locator/locator.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/presentation/blocs/taxi_overview.bloc.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/presentation/components/taxi_overview_active_orders.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/presentation/components/taxi_overview_kpis.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/presentation/components/taxi_overview_online_drivers.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/presentation/components/taxi_overview_pending_drivers.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/presentation/components/taxi_overview_pending_support_requests.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/presentation/components/taxi_overview_top_active_drivers.dart';
import 'package:admin_frontend/features/taxi/taxi_overview/presentation/components/taxi_overview_top_spending_customers.dart';

@RoutePage()
class TaxiOverviewScreen extends StatelessWidget {
  const TaxiOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaxiOverviewBloc()
        ..add(
          TaxiOverviewEvent.started(
            currency: locator<AuthBloc>().state.selectedCurrency,
          ),
        ),
      child: BlocBuilder<TaxiOverviewBloc, TaxiOverviewState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              padding: context.pagePadding,
              color: context.colors.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DashboardHeader(),
                      const Spacer(),
                      SizedBox(
                        width: 200,
                        child: AppDroopdownCurrency(
                          isCompact: true,
                          showTitle: false,
                          onChanged: (currency) {
                            context.read<TaxiOverviewBloc>().add(
                              TaxiOverviewEvent.currencyChanged(currency!),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Skeletonizer(
                    enabled: state.isLoading,
                    enableSwitchAnimation: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TaxiOverviewKPIs(),
                        TaxiOverviewOnlineDrivers(),
                        TaxiOverviewActiveOrders(),
                        LayoutGrid(
                          columnSizes: context.responsive(
                            [1.fr],
                            lg: [1.fr, 1.fr],
                          ),
                          rowGap: 16,
                          columnGap: 16,
                          rowSizes: List.generate(
                            context.responsive(2, lg: 1),
                            (_) => auto,
                          ),
                          children: [
                            TaxiOverviewPendingDrivers(),
                            TaxiOverviewPendingSupportRequests(),
                          ],
                        ),
                        LayoutGrid(
                          columnSizes: context.responsive(
                            [1.fr],
                            lg: [1.fr, 1.fr],
                          ),
                          rowGap: 16,
                          columnGap: 16,
                          rowSizes: List.generate(
                            context.responsive(2, lg: 1),
                            (_) => 550.px,
                          ),
                          children: [
                            TaxiOverviewTopSpendingCustomers(),
                            TaxiOverviewTopActiveDrivers(),
                          ],
                        ),
                      ].separated(separator: const SizedBox(height: 24)),
                    ),
                  ),
                  const SizedBox(height: 64),
                  Center(child: CopyrightNotice()),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
