import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_orders/presentation/blocs/driver_detail_orders.bloc.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_orders/presentation/components/driver_detail_orders_table.dart';

class DriverDetailOrdersScreen extends StatefulWidget {
  const DriverDetailOrdersScreen({super.key, required this.driverId});

  final String driverId;

  @override
  State<DriverDetailOrdersScreen> createState() =>
      _DriverDetailOrdersScreenState();
}

class _DriverDetailOrdersScreenState extends State<DriverDetailOrdersScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverDetailOrdersBloc()..onStarted(widget.driverId),
      child: DriverDetailOrdersTable(),
    );
  }

  // ignore: unused_element
  Widget _tabbedContent() {
    return SizedBox();
    // AppToggleSwitchButtonGroup(
    //   selectedValue: _pageController.page?.round() ?? 0,
    //   onChanged: (value) => _pageController.jumpToPage(value),
    //   options: [
    //     ToggleSwitchButtonGroupOption(label: context.tr.list, value: 0),
    //     ToggleSwitchButtonGroupOption(
    //       label: context.tr.insights,
    //       value: 1,
    //     ),
    //   ],
    // ),
    // const SizedBox(height: 24),
    // SizedBox(
    //   height: 700,
    //   child: PageView(
    //     controller: _pageController,
    //     children: const [
    //       DriverDetailOrdersTable(),
    //       DriverDetailOrdersStatistics(),
    //     ],
    //   ),
    // ),
  }
}
