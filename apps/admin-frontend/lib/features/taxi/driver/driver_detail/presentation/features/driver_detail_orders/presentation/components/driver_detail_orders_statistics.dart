import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_orders/presentation/blocs/driver_detail_orders.bloc.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_orders/presentation/components/driver_detail_orders_statistics_earning.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_orders/presentation/components/driver_detail_orders_statistics_ride_acceptance.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_orders/presentation/components/driver_detail_orders_statistics_ride_rate.dart';

class DriverDetailOrdersStatistics extends StatelessWidget {
  const DriverDetailOrdersStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DriverDetailOrdersBloc>().fetchAllStatistics();
    return SingleChildScrollView(
      child: LayoutGrid(
        columnSizes: context.responsive([1.fr], lg: [1.fr, 1.fr]),
        rowGap: 16,
        columnGap: 16,
        rowSizes: List.generate(context.responsive(3, lg: 2), (index) => auto),
        children: <Widget>[
          const DriverDetailOrdersStatisticsRideAcceptance(),
          const DriverDetailOrdersStatisticsRideRate(),
          const DriverDetailOrdersStatisticsEarning().withGridPlacement(
            columnSpan: context.responsive(1, lg: 2),
          ),
        ],
      ),
    );
  }
}
