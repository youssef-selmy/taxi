import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_localization/localizations.dart';

import 'package:admin_frontend/features/taxi/fleet/presentation/blocs/fleet_drivers.cubit.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/components/fleet_driver_chart.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/components/fleet_drivers_list.dart';

class FleetDriversTab extends StatefulWidget {
  const FleetDriversTab({super.key, required this.fleetId});
  final String fleetId;
  @override
  State<FleetDriversTab> createState() => _FleetDriversTabState();
}

class _FleetDriversTabState extends State<FleetDriversTab> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FleetDriversBloc()..onStarted(widget.fleetId),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppToggleSwitchButtonGroup(
            selectedValue: _pageController.page?.round() ?? 0,
            onChanged: (value) => _pageController.jumpToPage(value),
            options: [
              ToggleSwitchButtonGroupOption(
                label: context.tr.information,
                value: 0,
              ),
              ToggleSwitchButtonGroupOption(
                label: context.tr.insights,
                value: 1,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: const [FleetDriverList(), FleetDriverChart()],
            ),
          ),
        ],
      ),
    );
  }
}
