import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/management_common/regions/presentation/blocs/regions.cubit.dart';
import 'package:admin_frontend/features/management_common/regions/presentation/screens/regions_list/pages/regions_insights.dart';
import 'package:admin_frontend/features/management_common/regions/presentation/screens/regions_list/pages/regions_list.dart';

@RoutePage()
class RegionsListScreen extends StatefulWidget {
  const RegionsListScreen({super.key});

  @override
  createState() => _RegionsListScreenState();
}

class _RegionsListScreenState extends State<RegionsListScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegionsBloc()..onStarted(),
      child: Container(
        margin: context.pagePadding,
        color: context.colors.surface,
        child: Column(
          children: [
            PageHeader(
              title: context.tr.regions,
              showBackButton: false,
              subtitle: context.tr.regionsSubtitle,
            ),
            const SizedBox(height: 16),
            // AppTabBar(
            //   tabs: [
            //     AppTabItem(title: context.translate.list),
            //     AppTabItem(title: context.translate.insights),
            //   ],
            //   tabController: tabController,
            //   isCompact: false,
            // ),
            // const SizedBox(
            //   height: 16,
            // ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [RegionsList(), RegionsInsights()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
