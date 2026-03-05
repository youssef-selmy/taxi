import 'package:better_assets/assets.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/organisms/data_table/table_pagination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/parking_feedback.graphql.mock.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/blocs/reviews_parking.cubit.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/compoents/review_parking.dart';

class ReviewsParking extends StatelessWidget {
  final String customerId;

  const ReviewsParking({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ReviewsParkingBloc()..onStarted(customerId: customerId),
      child: BlocBuilder<ReviewsParkingBloc, ReviewsParkingState>(
        builder: (context, state) {
          if (state.networkState.isLoaded &&
              (state.networkState.data?.parkingFeedbacks.nodes.isEmpty ??
                  true)) {
            return AppEmptyState(
              image: Assets.images.emptyStates.checklist,
              title: context.tr.notFound,
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.tr.reviewsCountTitle(
                  state.networkState.data?.parkingFeedbacks.totalCount ?? 0,
                ),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Skeletonizer(
                  enabled: state.networkState.isLoading,
                  child: ListView.separated(
                    itemCount:
                        state.networkState.data?.parkingFeedbacks.totalCount ??
                        5,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final review =
                          state
                              .networkState
                              .data
                              ?.parkingFeedbacks
                              .nodes[index] ??
                          mockParkingFeedback1;
                      return ReviewParking(review: review);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (state.networkState.data?.parkingFeedbacks.pageInfo !=
                  null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TablePagination(
                      pageInfo: state
                          .networkState
                          .data!
                          .parkingFeedbacks
                          .pageInfo
                          .pageInfo,
                      paging: state.paging?.offsetPaging,
                      onPageChanged: context
                          .read<ReviewsParkingBloc>()
                          .onPageChanged
                          .pageChangedFn,
                    ),
                  ],
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
