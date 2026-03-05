import 'package:flutter/material.dart';

import 'package:better_design_system/atoms/toggle_switch_button_group/toggle_switch_button_group.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_credit_records/presentation/blocs/driver_detail_credit_records.bloc.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_credit_records/presentation/components/driver_detail_credit_records_statistics.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_credit_records/presentation/components/driver_detail_credit_records_table.dart';

class DriverDetailCreditRecordsScreen extends StatefulWidget {
  const DriverDetailCreditRecordsScreen({super.key, required this.driverId});
  final String driverId;
  @override
  State<DriverDetailCreditRecordsScreen> createState() =>
      _DriverDetailCreditRecordsScreenState();
}

class _DriverDetailCreditRecordsScreenState
    extends State<DriverDetailCreditRecordsScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DriverDetailCreditRecordsBloc()..onStarted(widget.driverId),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppToggleSwitchButtonGroup(
            selectedValue: _currentPage,
            onChanged: (value) {
              _pageController.jumpToPage(value);
              setState(() {
                _currentPage = value;
              });
            },
            options: [
              ToggleSwitchButtonGroupOption(
                label: context.tr.transactions,
                value: 0,
              ),
              ToggleSwitchButtonGroupOption(
                label: context.tr.insights,
                value: 1,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  _currentPage = value;
                });
              },
              children: const [
                DriverDetailCreditRecordsTable(),
                DriverDetailCreditRecordsStatistics(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
