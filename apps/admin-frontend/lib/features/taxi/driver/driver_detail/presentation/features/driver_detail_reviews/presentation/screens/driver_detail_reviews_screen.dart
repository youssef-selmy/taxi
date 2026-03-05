import 'package:flutter/material.dart';

import 'package:api_response/api_response.dart';
import 'package:auto_route/auto_route.dart';
import 'package:better_design_system/atoms/avatar/avatar.dart';
import 'package:better_design_system/atoms/buttons/text_button.dart';
import 'package:better_design_system/organisms/data_table/table_pagination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:admin_frontend/core/components/rating_indicator.dart';
import 'package:admin_frontend/core/extensions/extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/driver.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/page_info.mock.dart';
import 'package:admin_frontend/core/graphql/fragments/review_taxi.graphql.extensions.dart';
import 'package:admin_frontend/core/graphql/fragments/review_taxi.graphql.mock.dart';
import 'package:admin_frontend/core/router/app_router.dart';
import 'package:admin_frontend/features/taxi/driver/driver_detail/presentation/features/driver_detail_reviews/presentation/blocs/driver_detail_reviews.bloc.dart';
import 'package:better_icons/better_icons.dart';

class DriverDetailReviewsScreen extends StatelessWidget {
  const DriverDetailReviewsScreen({super.key, required this.driverId});

  final String driverId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverDetailReviewsBloc()..onStarted(driverId),
      child: BlocBuilder<DriverDetailReviewsBloc, DriverDetailReviewsState>(
        builder: (context, state) {
          return switch (state.driverReviewsState) {
            ApiResponseInitial() => const SizedBox(),
            ApiResponseLoading() || ApiResponseLoaded() => Column(
              children: [
                Expanded(
                  child: Skeletonizer(
                    enabled: state.driverReviewsState.isLoading,
                    enableSwitchAnimation: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.driverReviewsState.isLoading
                              ? '${context.tr.reviews} (14)'
                              : '${context.tr.reviews} (${state.driverReviewsState.data?.reviews.totalCount ?? 0})',
                          style: context.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 8),
                            itemCount: state.driverReviewsState.isLoading
                                ? 4
                                : state
                                          .driverReviewsState
                                          .data
                                          ?.reviews
                                          .nodes
                                          .length ??
                                      0,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final review = state.driverReviewsState.isLoading
                                  ? mockReviewTaxi1
                                  : state
                                        .driverReviewsState
                                        .data
                                        ?.reviews
                                        .nodes[index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: context.colors.surface,
                                  border: Border.all(
                                    color: context.colors.outline,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            context.tr.reviewBy,
                                            style: context.textTheme.labelMedium
                                                ?.variant(context),
                                          ),
                                          Text(
                                            review
                                                    ?.reviewTimestamp
                                                    .formatDateTime ??
                                                '',
                                            style: context.textTheme.labelMedium
                                                ?.variant(context),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: <Widget>[
                                              AppAvatar(
                                                imageUrl: review
                                                    ?.driver
                                                    .media
                                                    ?.address,
                                                size: AvatarSize.size40px,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                review?.driver.fullName ?? '',
                                                style: context
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              const SizedBox(width: 16),
                                              RatingIndicator(
                                                rating: review?.score ?? 0,
                                              ),
                                            ],
                                          ),
                                          AppTextButton(
                                            text: context.tr.viewOrder,
                                            onPressed: () {
                                              context.router.navigate(
                                                TaxiShellRoute(
                                                  children: [
                                                    TaxiOrderShellRoute(
                                                      children: [
                                                        TaxiOrderDetailRoute(
                                                          orderId:
                                                              review!.requestId,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            suffixIcon:
                                                BetterIcons.arrowRight02Outline,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          review?.description ?? '',
                                          style: context.textTheme.labelMedium
                                              ?.variant(context),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          if (review!.parameters
                                              .where((e) => e.isGood == true)
                                              .isNotEmpty) ...[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  context.tr.goodPoints,
                                                  style: context
                                                      .textTheme
                                                      .labelMedium
                                                      ?.copyWith(
                                                        color: context
                                                            .colors
                                                            .success,
                                                      ),
                                                ),
                                                const SizedBox(height: 4),
                                                Wrap(
                                                  spacing: 4,
                                                  runSpacing: 4,
                                                  children: review.parameters
                                                      .where(
                                                        (e) => e.isGood == true,
                                                      )
                                                      .map(
                                                        (e) => e.view(context),
                                                      )
                                                      .toList(),
                                                ),
                                              ],
                                            ),
                                          ],
                                          if (review.parameters
                                              .where((e) => e.isGood == true)
                                              .isNotEmpty)
                                            const SizedBox(width: 24),
                                          if (review.parameters
                                              .where((e) => e.isGood == false)
                                              .isNotEmpty) ...[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  context.tr.badPoints,
                                                  style: context
                                                      .textTheme
                                                      .labelMedium
                                                      ?.copyWith(
                                                        color: context
                                                            .colors
                                                            .error,
                                                      ),
                                                ),
                                                const SizedBox(height: 4),
                                                Wrap(
                                                  spacing: 4,
                                                  runSpacing: 4,
                                                  children: review.parameters
                                                      .where(
                                                        (e) =>
                                                            e.isGood == false,
                                                      )
                                                      .map(
                                                        (e) => e.view(context),
                                                      )
                                                      .toList(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TablePagination(
                      pageInfo: state.driverReviewsState.isLoading
                          ? mockPageInfo.pageInfo
                          : state
                                .driverReviewsState
                                .data!
                                .reviews
                                .pageInfo
                                .pageInfo,
                      onPageChanged: context
                          .read<DriverDetailReviewsBloc>()
                          .onPageChanged
                          .pageChangedFn,
                      paging: state.paging?.offsetPaging,
                    ),
                  ],
                ),
                SizedBox(height: 24),
              ],
            ),
            ApiResponseError(:final message) => Text(message),
          };
        },
      ),
    );
  }
}
