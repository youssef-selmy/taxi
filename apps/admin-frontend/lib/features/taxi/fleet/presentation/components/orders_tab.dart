import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/taxi/fleet/presentation/blocs/fleet_order.cubit.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/components/orders_list.dart';

class FleetOrdersTab extends StatefulWidget {
  const FleetOrdersTab({super.key, required this.fleetId});
  final String fleetId;
  @override
  State<FleetOrdersTab> createState() => _FleetOrdersTabState();
}

class _FleetOrdersTabState extends State<FleetOrdersTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FleetOrderBloc()..onStarted(widget.fleetId),
      child: OrdersList(),
      // child: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: <Widget>[
      //     AppToggleSwitchButtonGroup(
      //       selectedValue: _pageController.page?.round() ?? 0,
      //       onChanged: (value) => _pageController.jumpToPage(value),
      //       options: [
      //         ToggleSwitchButtonGroupOption(
      //           label: context.tr.information,
      //           value: 0,
      //         ),
      //         ToggleSwitchButtonGroupOption(
      //           label: context.tr.insights,
      //           value: 1,
      //         ),
      //       ],
      //     ),
      //     const SizedBox(height: 16),
      //     Expanded(
      //       child: PageView(
      //         controller: _pageController,
      //         children: const [OrdersList(), FleetOrdersChartsTab()],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
