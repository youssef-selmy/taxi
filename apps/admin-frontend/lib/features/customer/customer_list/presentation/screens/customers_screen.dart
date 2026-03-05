import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_container.dart';
import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/blocs/customers.cubit.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/blocs/customers_statistics.cubit.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/components/customers_list.dart';
import 'package:admin_frontend/features/customer/customer_list/presentation/components/customers_statistics.dart';

@RoutePage()
class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CustomersBloc()..onInit()),
        BlocProvider(create: (context) => CustomersStatisticsBloc()),
      ],
      child: PageContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeader(
              title: context.tr.customers,
              subtitle: context.tr.customersSubtitle,
            ),
            const SizedBox(height: 16),
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              tabs: [
                Tab(text: context.tr.customers),
                Tab(text: context.tr.insights),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: TabBarView(
                clipBehavior: Clip.none,
                controller: _tabController,
                children: const [CustomersList(), CustomersStatistics()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
