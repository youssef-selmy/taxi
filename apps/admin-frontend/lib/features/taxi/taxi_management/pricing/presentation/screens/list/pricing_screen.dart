import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/components/tab_bar/tab_bar.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/presentation/blocs/pricing_list.cubit.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/presentation/screens/list/tabs/pricing_list_tab.dart';
import 'package:admin_frontend/features/taxi/taxi_management/pricing/presentation/screens/list/tabs/zone_overrides_tab.dart';

@RoutePage()
class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PricingListBloc(),
      child: Container(
        margin: context.pagePadding,
        color: context.colors.surface,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeader(
              title: context.tr.pricing,
              subtitle: context.tr.pricingSubtitle,
              showBackButton: false,
            ),
            const SizedBox(height: 16),
            AppTabBar(
              tabs: [
                AppTabItem(title: context.tr.list),
                AppTabItem(title: context.tr.overriddenZones),
              ],
              tabController: tabController,
              isCompact: false,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [PricingListTab(), ZoneOverridesTab()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
