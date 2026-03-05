import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/map/generic_map.dart';
import 'package:admin_frontend/core/components/molecules/dropdown_currency/droopdown_currency.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/blocs/driver_list.bloc.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/components/driver_list_active_inactive_statistics.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/components/driver_list_earning_distribution_statistics.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/components/driver_list_earning_over_time_statistics.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/components/driver_list_ride_acceptance_rate_statistics.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/components/driver_list_ride_rating_statistics.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/components/driver_list_statistics_cards.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/components/driver_list_trips_statistics.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/components/drivers_list_top_earning_statistics.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/components/drivers_list_top_spending_statistics.dart';

class DriverListStatistics extends StatelessWidget {
  const DriverListStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverListBloc()..fetchAllDriverStatistics(),
      child: BlocBuilder<DriverListBloc, DriverListState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: context.pagePaddingHorizontal.copyWith(bottom: 16),
            clipBehavior: Clip.none,
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          context.tr.insights,
                          style: context.textTheme.titleMedium,
                        ),
                      ),
                      Expanded(
                        child: AppDroopdownCurrency(
                          isCompact: true,
                          showTitle: false,
                          onChanged: (value) {
                            context.read<DriverListBloc>().onCurrencyChange(
                              value!,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Skeletonizer(
                    enableSwitchAnimation: true,
                    enabled: state.driverStatisticsState.isLoading,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DriverListStatisticsCards(),
                        LayoutGrid(
                          columnSizes: context.responsive(
                            [1.fr],
                            lg: [1.fr, 1.fr],
                          ),
                          rowGap: 16,
                          columnGap: 16,
                          rowSizes: const [
                            auto,
                            auto,
                            auto,
                            auto,
                            auto,
                            auto,
                            auto,
                            auto,
                            auto,
                            auto,
                            auto,
                            auto,
                          ],
                          children: [
                            const DriverListActiveInactiveStatistics(),
                            const DriversListTopSpendingStatistics(),
                            const DriverListTripsStatistics().withGridPlacement(
                              columnSpan: context.responsive(1, lg: 2),
                            ),
                            Text(
                              context.tr.driverEarnings,
                              style: context.textTheme.titleMedium,
                            ).withGridPlacement(
                              columnSpan: context.responsive(1, lg: 2),
                            ),
                            const DriverListEarningDistributionStatistics(),
                            const DriversListTopEarningStatistics(),
                            const DriverListEarningOverTimeStatistics()
                                .withGridPlacement(
                                  columnSpan: context.responsive(1, lg: 2),
                                ),
                            Text(
                              context.tr.rideRequests,
                              style: context.textTheme.titleMedium,
                            ).withGridPlacement(
                              columnSpan: context.responsive(1, lg: 2),
                            ),
                            const DriverListRideAcceptanceRateStatistics(),
                            const DriverListRideCompletionChat(),
                            Text(
                              context.tr.geographicalDistribution,
                              style: context.textTheme.titleMedium,
                            ).withGridPlacement(
                              columnSpan: context.responsive(1, lg: 2),
                            ),
                            SizedBox(
                              height: 377,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: AppGenericMap(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 100,
                                    vertical: 60,
                                  ),
                                  mode: MapViewMode.static,
                                  interactive: false,
                                ),
                              ),
                            ).withGridPlacement(
                              columnSpan: context.responsive(1, lg: 2),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
