import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:admin_frontend/core/components/page_header/page_header.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/features/parking/parking_review/parking_review_list/presentation/blocs/parking_review_list.cubit.dart';
import 'package:admin_frontend/features/parking/parking_review/parking_review_list/presentation/components/parking_review_list_table.dart';

@RoutePage()
class ParkingReviewListScreen extends StatelessWidget {
  const ParkingReviewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParkingReviewListBloc()..onStarted(),
      child: BlocBuilder<ParkingReviewListBloc, ParkingReviewListState>(
        builder: (context, state) {
          return Container(
            margin: context.pagePadding,
            color: context.colors.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageHeader(
                  title: context.tr.feedbacks,
                  subtitle: context.tr.userPostedReviewsList,
                ),
                const SizedBox(height: 16),
                const Expanded(child: ParkingReviewListTable()),
              ],
            ),
          );
        },
      ),
    );
  }
}
