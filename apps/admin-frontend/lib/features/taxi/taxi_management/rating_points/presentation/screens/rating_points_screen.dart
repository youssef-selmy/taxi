import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/taxi/taxi_management/rating_points/presentation/blocs/rating_points.cubit.dart';
import 'package:admin_frontend/features/taxi/taxi_management/rating_points/presentation/screens/pages/insights.dart';
import 'package:admin_frontend/features/taxi/taxi_management/rating_points/presentation/screens/pages/list.dart';

@RoutePage()
class TaxiRatingPointsScreen extends StatefulWidget {
  const TaxiRatingPointsScreen({super.key});

  @override
  State<TaxiRatingPointsScreen> createState() => _TaxiRatingPointsScreenState();
}

class _TaxiRatingPointsScreenState extends State<TaxiRatingPointsScreen>
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
      create: (context) => RatingPointsBloc()..onStarted(),
      child: Container(
        margin: context.pagePadding,
        color: context.colors.surface,
        child: Column(
          children: [
            PageHeader(
              title: context.tr.ratingPoints,
              subtitle: context.tr.ratingPointsSubtitle,
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
                children: const [RatingPointsList(), RatingPointsInsights()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
