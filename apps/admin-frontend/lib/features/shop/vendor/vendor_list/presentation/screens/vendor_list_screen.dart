import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_list/presentation/blocs/vendor_list.cubit.dart';
import 'package:admin_frontend/features/shop/vendor/vendor_list/presentation/screens/tabs/vendor_list_vendors_tab.dart';

@RoutePage()
class VendorListScreen extends StatefulWidget {
  const VendorListScreen({super.key});

  @override
  State<VendorListScreen> createState() => _VendorListScreenState();
}

class _VendorListScreenState extends State<VendorListScreen>
    with SingleTickerProviderStateMixin {
  // late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(
    //   length: 2,
    //   vsync: this,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VendorListBloc()..onStarted(),
      child: PageContainer(
        child: Column(
          children: [
            PageHeader(
              title: context.tr.shops,
              subtitle: context.tr.shopsSubtitle,
            ),
            const SizedBox(height: 16),
            // AppTabBar(
            //   tabs: [
            //     AppTabItem(
            //       title: "Shop List",
            //     ),
            //     AppTabItem(
            //       title: context.translate.insights,
            //     ),
            //   ],
            //   tabController: _tabController,
            //   isCompact: false,
            // ),
            const SizedBox(height: 12),
            Expanded(
              child: VendorListVendorsTab(),
              // child: TabBarView(
              //   controller: _tabController,
              //   children: [
              //     const VendorListVendorsTab(),
              //     const VendorListStatisticsTab(),
              //   ],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
