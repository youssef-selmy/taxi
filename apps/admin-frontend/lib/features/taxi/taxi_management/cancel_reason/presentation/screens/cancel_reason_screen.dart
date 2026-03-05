import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/presentation/blocs/cancel_reason.cubit.dart';
import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/presentation/screens/pages/insights.dart';
import 'package:admin_frontend/features/taxi/taxi_management/cancel_reason/presentation/screens/pages/list.dart';

@RoutePage()
class CancelReasonScreen extends StatefulWidget {
  const CancelReasonScreen({super.key});

  @override
  State<CancelReasonScreen> createState() => _CancelReasonScreenState();
}

class _CancelReasonScreenState extends State<CancelReasonScreen>
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
      create: (context) => CancelReasonBloc()..onStarted(),
      child: Container(
        color: context.colors.surface,
        margin: context.pagePadding,
        child: Column(
          children: [
            PageHeader(
              title: context.tr.cancelReasons,
              subtitle: context.tr.cancelReasonsSubtitle,
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
                children: const [CancelReasonList(), CancelReasonsInsights()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
