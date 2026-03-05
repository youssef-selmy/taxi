import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/blocs/driver_list.bloc.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/components/driver_list_statistics.dart';
import 'package:admin_frontend/features/taxi/driver/driver_list/presentation/components/driver_list_table.dart';

@RoutePage()
class DriverListScreen extends StatefulWidget {
  const DriverListScreen({super.key});

  @override
  State<DriverListScreen> createState() => _DriverListScreenState();
}

class _DriverListScreenState extends State<DriverListScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverListBloc()..onStarted(),
      child: Container(
        margin: EdgeInsets.only(top: context.responsive(16, lg: 40)),
        color: context.colors.surface,
        child: AnimatedSwitcher(
          duration: kThemeAnimationDuration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: context.pagePaddingHorizontal,
                child: PageHeader(
                  title: context.tr.drivers,
                  subtitle: 'List of all the drivers registered',
                ),
              ),
              const SizedBox(height: 16),
              // TODO: Uncomment when the insights tab is ready
              // Padding(
              //   padding: context.pagePaddingHorizontal,
              //   child: AppTabBar(
              //     tabController: _tabController,
              //     isCompact: false,
              //     tabs: [
              //       AppTabItem(
              //         title: context.translate.list,
              //       ),
              //       AppTabItem(
              //         title: context.translate.insights,
              //       ),
              //     ],
              //   ),
              // ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [DriverListTable(), DriverListStatistics()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
