import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/blocs/park_spot_detail_orders.cubit.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/screens/tabs/park_spot_detail_orders_active_tab.dart';
import 'package:admin_frontend/features/parking/park_spot/park_spot_detail/presentation/screens/tabs/park_spot_detail_orders_history_tab.dart';

class ParkSpotDetailOrdersTab extends StatelessWidget {
  final String parkSpotId;

  const ParkSpotDetailOrdersTab({super.key, required this.parkSpotId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ParkSpotDetailOrdersBloc()..onStarted(parkSpotId: parkSpotId),
      child: BlocBuilder<ParkSpotDetailOrdersBloc, ParkSpotDetailOrdersState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppToggleSwitchButtonGroup<int>(
                options: [
                  ToggleSwitchButtonGroupOption(
                    label: context.tr.active,
                    value: 0,
                  ),
                  ToggleSwitchButtonGroupOption(
                    label: context.tr.history,
                    value: 1,
                  ),
                ],
                selectedValue: state.selectedTab,
                onChanged: context
                    .read<ParkSpotDetailOrdersBloc>()
                    .onTabSelected,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: IndexedStack(
                  index: state.selectedTab,
                  children: [
                    ParkSpotDetailOrdersActiveTab(parkSpotId: parkSpotId),
                    ParkSpotDetailOrdersHistoryTab(parkSpotId: parkSpotId),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
