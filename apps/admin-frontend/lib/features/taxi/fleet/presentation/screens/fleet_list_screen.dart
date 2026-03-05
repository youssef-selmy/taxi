import 'package:better_localization/localizations.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/blocs/fleet_list.cubit.dart';
import 'package:admin_frontend/features/taxi/fleet/presentation/components/fleet_list.dart';

@RoutePage()
class FleetListScreen extends StatefulWidget {
  const FleetListScreen({super.key});

  @override
  State<FleetListScreen> createState() => _FleetListScreenState();
}

class _FleetListScreenState extends State<FleetListScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FleetListBloc()..onStarted(),
      child: PageContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeader(
              title: context.tr.fleets,
              subtitle: context.tr.listOfAllTheFleetsRegistered,
            ),
            const SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 40),
            //   child: TabBar(
            //     controller: _tabController,
            //     isScrollable: true,
            //     tabAlignment: TabAlignment.start,
            //     tabs: const [
            //       Tab(
            //         text: 'Fleets List',
            //       ),
            //       Tab(
            //         text: 'Fleets Statistics ',
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 24),
            Expanded(
              child: TabBarView(
                clipBehavior: Clip.none,
                controller: _tabController,
                children: const [FleetList(), SizedBox()],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
