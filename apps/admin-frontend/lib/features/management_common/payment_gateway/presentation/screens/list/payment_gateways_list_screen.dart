import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/buttons/outlined_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/management_common/payment_gateway/presentation/blocs/payment_gateway_list.cubit.dart';
import 'package:admin_frontend/features/management_common/payment_gateway/presentation/screens/list/pages/insights.dart';
import 'package:admin_frontend/features/management_common/payment_gateway/presentation/screens/list/pages/list.dart';
import 'package:better_icons/better_icons.dart';

@RoutePage()
class PaymentGatewaysListScreen extends StatefulWidget {
  const PaymentGatewaysListScreen({super.key});

  @override
  State<PaymentGatewaysListScreen> createState() =>
      _PaymentGatewaysListScreenState();
}

class _PaymentGatewaysListScreenState extends State<PaymentGatewaysListScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentGatewayListBloc()..onStarted(),
      child: Container(
        margin: context.pagePadding,
        color: context.colors.surface,
        child: Column(
          children: [
            PageHeader(
              title: context.tr.paymentGateways,
              subtitle: context.tr.paymentGatewaysSubtitle,
              actions: [
                AppOutlinedButton(
                  onPressed: () async {
                    await context.router.push(PaymentGatewayDetailsRoute());
                    // ignore: use_build_context_synchronously
                    context.read<PaymentGatewayListBloc>().refresh();
                  },
                  prefixIcon: BetterIcons.addCircleOutline,
                  text: context.tr.add,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // AppTabBar(
            //   tabs: [
            //     AppTabItem(title: context.translate.list),
            //     AppTabItem(title: context.translate.insights),
            //   ],
            //   tabController: _tabController,
            //   isCompact: false,
            // ),
            // const SizedBox(
            //   height: 16,
            // ),
            Expanded(
              // child: PaymentGatewaysListPage(),
              child: TabBarView(
                controller: _tabController,
                children: const [
                  PaymentGatewaysListPage(),
                  PaymentGatewaysInsightsPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
