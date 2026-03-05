import 'package:better_assets/assets.dart';
import 'package:better_design_system/organisms/empty_state/empty_state.dart';
import 'package:flutter/material.dart';

import 'package:better_design_system/organisms/data_table/table_pagination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/shop_feedback.graphql.mock.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/blocs/reviews_shop.cubit.dart';
import 'package:admin_frontend/features/customer/customer_detail/presentation/compoents/review_shop.dart';

class ReviewsShop extends StatelessWidget {
  final String customerId;

  const ReviewsShop({super.key, required this.customerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewsShopBloc()..onStarted(customerId: customerId),
      child: BlocBuilder<ReviewsShopBloc, ReviewsShopState>(
        builder: (context, state) {
          if (state.networkState.isLoaded &&
              (state.networkState.data?.shopFeedbacks.nodes.isEmpty ?? true)) {
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
                  state.networkState.data?.shopFeedbacks.totalCount ?? 0,
                ),
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Skeletonizer(
                  enabled: state.networkState.isLoading,
                  child: ListView.separated(
                    itemCount:
                        state.networkState.data?.shopFeedbacks.totalCount ?? 5,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final review =
                          state.networkState.data?.shopFeedbacks.nodes[index] ??
                          mockShopFeedback1;
                      return ReviewShop(review: review);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              if (state.networkState.data?.shopFeedbacks.pageInfo != null) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TablePagination(
                      pageInfo: state
                          .networkState
                          .data!
                          .shopFeedbacks
                          .pageInfo
                          .pageInfo,
                      paging: state.paging?.offsetPaging,
                      onPageChanged: context
                          .read<ReviewsShopBloc>()
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
