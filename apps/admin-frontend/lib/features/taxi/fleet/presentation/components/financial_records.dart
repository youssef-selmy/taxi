import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/taxi/fleet/presentation/blocs/financial_records.cubit.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/components/financial_informations.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/components/financial_statistics.dart';

class FinancialRecordsTab extends StatefulWidget {
  final String fleetId;

  const FinancialRecordsTab({super.key, required this.fleetId});

  @override
  State<FinancialRecordsTab> createState() => _FinancialRecordsTabState();
}

class _FinancialRecordsTabState extends State<FinancialRecordsTab> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FleetFinancialRecordsBloc()..onStarted(fleetId: widget.fleetId),
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
                label: context.tr.statistics,
                value: 1,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: const [FinancialInformations(), FinancialStatistics()],
            ),
          ),
        ],
      ),
    );
  }
}
